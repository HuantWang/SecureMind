func (a *HorizontalController) reconcileAutoscaler(ctx context.Context, hpaShared *autoscalingv2.HorizontalPodAutoscaler, key string) error {
		hpa := hpaShared.DeepCopy()
	hpaStatusOriginal := hpa.Status.DeepCopy()

		a.ensureScalingBehaviorsNotPartiallyPopulated(hpa)

	reference := fmt.Sprintf("%s/%s/%s", hpa.Spec.ScaleTargetRef.Kind, hpa.Namespace, hpa.Spec.ScaleTargetRef.Name)

	targetGV, err := schema.ParseGroupVersion(hpa.Spec.ScaleTargetRef.APIVersion)
	if err != nil {
		a.eventRecorder.Event(hpa, v1.EventTypeWarning, "FailedGetScale", err.Error())
		setCondition(hpa, autoscalingv2.AbleToScale, v1.ConditionFalse, "FailedGetScale", "the HPA controller was unable to get the target's current scale: %v", err)
		if err := a.updateStatusIfNeeded(ctx, hpaStatusOriginal, hpa); err != nil {
			utilruntime.HandleError(err)
		}
		return fmt.Errorf("invalid API version in scale target reference: %v", err)
	}

	targetGK := schema.GroupKind{
		Group: targetGV.Group,
		Kind:  hpa.Spec.ScaleTargetRef.Kind,
	}

	mappings, err := a.mapper.RESTMappings(targetGK)
	if err != nil {
		a.eventRecorder.Event(hpa, v1.EventTypeWarning, "FailedGetScale", err.Error())
		setCondition(hpa, autoscalingv2.AbleToScale, v1.ConditionFalse, "FailedGetScale", "the HPA controller was unable to get the target's current scale: %v", err)
		if err := a.updateStatusIfNeeded(ctx, hpaStatusOriginal, hpa); err != nil {
			utilruntime.HandleError(err)
		}
		return fmt.Errorf("unable to determine resource for scale target reference: %v", err)
	}

	scale, targetGR, err := a.scaleForResourceMappings(ctx, hpa.Namespace, hpa.Spec.ScaleTargetRef.Name, mappings)
	if err != nil {
		a.eventRecorder.Event(hpa, v1.EventTypeWarning, "FailedGetScale", err.Error())
		setCondition(hpa, autoscalingv2.AbleToScale, v1.ConditionFalse, "FailedGetScale", "the HPA controller was unable to get the target's current scale: %v", err)
		if err := a.updateStatusIfNeeded(ctx, hpaStatusOriginal, hpa); err != nil {
			utilruntime.HandleError(err)
		}
		return fmt.Errorf("failed to query scale subresource for %s: %v", reference, err)
	}
	setCondition(hpa, autoscalingv2.AbleToScale, v1.ConditionTrue, "SucceededGetScale", "the HPA controller was able to get the target's current scale")
	currentReplicas := scale.Spec.Replicas
	a.recordInitialRecommendation(currentReplicas, key)

	var (
		metricStatuses        []autoscalingv2.MetricStatus
		metricDesiredReplicas int32
		metricName            string
	)

	desiredReplicas := int32(0)
	rescaleReason := ""

	var minReplicas int32

	if hpa.Spec.MinReplicas != nil {
		minReplicas = *hpa.Spec.MinReplicas
	} else {
				minReplicas = 1
	}

	rescale := true

	if scale.Spec.Replicas == 0 && minReplicas != 0 {
				desiredReplicas = 0
		rescale = false
		setCondition(hpa, autoscalingv2.ScalingActive, v1.ConditionFalse, "ScalingDisabled", "scaling is disabled since the replica count of the target is zero")
	} else if currentReplicas > hpa.Spec.MaxReplicas {
		rescaleReason = "Current number of replicas above Spec.MaxReplicas"
		desiredReplicas = hpa.Spec.MaxReplicas
	} else if currentReplicas < minReplicas {
		rescaleReason = "Current number of replicas below Spec.MinReplicas"
		desiredReplicas = minReplicas
	} else {
		var metricTimestamp time.Time
		metricDesiredReplicas, metricName, metricStatuses, metricTimestamp, err = a.computeReplicasForMetrics(ctx, hpa, scale, hpa.Spec.Metrics)
		if err != nil {
			a.setCurrentReplicasInStatus(hpa, currentReplicas)
			if err := a.updateStatusIfNeeded(ctx, hpaStatusOriginal, hpa); err != nil {
				utilruntime.HandleError(err)
			}
			a.eventRecorder.Event(hpa, v1.EventTypeWarning, "FailedComputeMetricsReplicas", err.Error())
			return fmt.Errorf("failed to compute desired number of replicas based on listed metrics for %s: %v", reference, err)
		}

		klog.V(4).Infof("proposing %v desired replicas (based on %s from %s) for %s", metricDesiredReplicas, metricName, metricTimestamp, reference)

		rescaleMetric := ""
		if metricDesiredReplicas > desiredReplicas {
			desiredReplicas = metricDesiredReplicas
			rescaleMetric = metricName
		}
		if desiredReplicas > currentReplicas {
			rescaleReason = fmt.Sprintf("%s above target", rescaleMetric)
		}
		if desiredReplicas < currentReplicas {
			rescaleReason = "All metrics below target"
		}
		if hpa.Spec.Behavior == nil {
			desiredReplicas = a.normalizeDesiredReplicas(hpa, key, currentReplicas, desiredReplicas, minReplicas)
		} else {
			desiredReplicas = a.normalizeDesiredReplicasWithBehaviors(hpa, key, currentReplicas, desiredReplicas, minReplicas)
		}
		rescale = desiredReplicas != currentReplicas
	}

	if rescale {
		scale.Spec.Replicas = desiredReplicas
		_, err = a.scaleNamespacer.Scales(hpa.Namespace).Update(ctx, targetGR, scale, metav1.UpdateOptions{})
		if err != nil {
			a.eventRecorder.Eventf(hpa, v1.EventTypeWarning, "FailedRescale", "New size: %d; reason: %s; error: %v", desiredReplicas, rescaleReason, err.Error())
			setCondition(hpa, autoscalingv2.AbleToScale, v1.ConditionFalse, "FailedUpdateScale", "the HPA controller was unable to update the target scale: %v", err)
			a.setCurrentReplicasInStatus(hpa, currentReplicas)
			if err := a.updateStatusIfNeeded(ctx, hpaStatusOriginal, hpa); err != nil {
				utilruntime.HandleError(err)
			}
			return fmt.Errorf("failed to rescale %s: %v", reference, err)
		}
		setCondition(hpa, autoscalingv2.AbleToScale, v1.ConditionTrue, "SucceededRescale", "the HPA controller was able to update the target scale to %d", desiredReplicas)
		a.eventRecorder.Eventf(hpa, v1.EventTypeNormal, "SuccessfulRescale", "New size: %d; reason: %s", desiredReplicas, rescaleReason)
		a.storeScaleEvent(hpa.Spec.Behavior, key, currentReplicas, desiredReplicas)
		klog.Infof("Successful rescale of %s, old size: %d, new size: %d, reason: %s",
			hpa.Name, currentReplicas, desiredReplicas, rescaleReason)
	} else {
		klog.V(4).Infof("decided not to scale %s to %v (last scale time was %s)", reference, desiredReplicas, hpa.Status.LastScaleTime)
		desiredReplicas = currentReplicas
	}

	a.setStatus(hpa, currentReplicas, desiredReplicas, metricStatuses, rescale)
	return a.updateStatusIfNeeded(ctx, hpaStatusOriginal, hpa)
}






func min(a, b int32) int32 {
	if a <= b {
		return a
	}
	return b
}

func (a *HorizontalController) ensureScalingBehaviorsNotPartiallyPopulated(hpa *autoscalingv2.HorizontalPodAutoscaler) {
	if hpa.Spec.Behavior != nil {
		hpa.Spec.Behavior.ScaleUp = autoscalingapiv2.GenerateHPAScaleUpRules(hpa.Spec.Behavior.ScaleUp)
		hpa.Spec.Behavior.ScaleDown = autoscalingapiv2.GenerateHPAScaleDownRules(hpa.Spec.Behavior.ScaleDown)
	}
}


func (tc *testCase) prepareTestClient(t *testing.T) (*fake.Clientset, *metricsfake.Clientset, *cmfake.FakeCustomMetricsClient, *emfake.FakeExternalMetricsClient, *scalefake.FakeScaleClient) {
	namespace := "test-namespace"
	hpaName := "test-hpa"
	podNamePrefix := "test-pod"
	labelSet := map[string]string{"name": podNamePrefix}
	selector := labels.SelectorFromSet(labelSet).String()

	tc.Lock()

	tc.scaleUpdated = false
	tc.statusUpdated = false
	tc.eventCreated = false
	tc.processed = make(chan string, 100)
	if tc.CPUCurrent == 0 {
		tc.computeCPUCurrent()
	}

	if tc.resource == nil {
		tc.resource = &fakeResource{
			name:       "test-rc",
			apiVersion: "v1",
			kind:       "ReplicationController",
		}
	}
	tc.Unlock()

	fakeClient := &fake.Clientset{}
	fakeClient.AddReactor("list", "horizontalpodautoscalers", func(action core.Action) (handled bool, ret runtime.Object, err error) {
		tc.Lock()
		defer tc.Unlock()
		var behavior *autoscalingv2.HorizontalPodAutoscalerBehavior
		if tc.scaleUpRules != nil || tc.scaleDownRules != nil {
			behavior = &autoscalingv2.HorizontalPodAutoscalerBehavior{
				ScaleUp:   tc.scaleUpRules,
				ScaleDown: tc.scaleDownRules,
			}
		}
		hpa := autoscalingv2.HorizontalPodAutoscaler{
			ObjectMeta: metav1.ObjectMeta{
				Name:      hpaName,
				Namespace: namespace,
			},
			Spec: autoscalingv2.HorizontalPodAutoscalerSpec{
				ScaleTargetRef: autoscalingv2.CrossVersionObjectReference{
					Kind:       tc.resource.kind,
					Name:       tc.resource.name,
					APIVersion: tc.resource.apiVersion,
				},
				MinReplicas: &tc.minReplicas,
				MaxReplicas: tc.maxReplicas,
				Behavior:    behavior,
			},
			Status: autoscalingv2.HorizontalPodAutoscalerStatus{
				CurrentReplicas: tc.specReplicas,
				DesiredReplicas: tc.specReplicas,
				LastScaleTime:   tc.lastScaleTime,
			},
		}
		
		obj := &autoscalingv2.HorizontalPodAutoscalerList{
			Items: []autoscalingv2.HorizontalPodAutoscaler{hpa},
		}

		if tc.CPUTarget > 0 {
			obj.Items[0].Spec.Metrics = []autoscalingv2.MetricSpec{
				{
					Type: autoscalingv2.ResourceMetricSourceType,
					Resource: &autoscalingv2.ResourceMetricSource{
						Name: v1.ResourceCPU,
						Target: autoscalingv2.MetricTarget{
							Type:               autoscalingv2.UtilizationMetricType,
							AverageUtilization: &tc.CPUTarget,
						},
					},
				},
			}
		}
		if len(tc.metricsTarget) > 0 {
			obj.Items[0].Spec.Metrics = append(obj.Items[0].Spec.Metrics, tc.metricsTarget...)
		}

		if len(obj.Items[0].Spec.Metrics) == 0 {
						obj.Items[0].Spec.Metrics = []autoscalingv2.MetricSpec{
				{
					Type: autoscalingv2.ResourceMetricSourceType,
					Resource: &autoscalingv2.ResourceMetricSource{
						Name: v1.ResourceCPU,
					},
				},
			}
		}

		return true, obj, nil
	})

	fakeClient.AddReactor("list", "pods", func(action core.Action) (handled bool, ret runtime.Object, err error) {
		tc.Lock()
		defer tc.Unlock()

		obj := &v1.PodList{}

		specifiedCPURequests := tc.reportedCPURequests != nil

		numPodsToCreate := int(tc.statusReplicas)
		if specifiedCPURequests {
			numPodsToCreate = len(tc.reportedCPURequests)
		}

		for i := 0; i < numPodsToCreate; i++ {
			podReadiness := v1.ConditionTrue
			if tc.reportedPodReadiness != nil {
				podReadiness = tc.reportedPodReadiness[i]
			}
			var podStartTime metav1.Time
			if tc.reportedPodStartTime != nil {
				podStartTime = tc.reportedPodStartTime[i]
			}

			podPhase := v1.PodRunning
			if tc.reportedPodPhase != nil {
				podPhase = tc.reportedPodPhase[i]
			}

			podDeletionTimestamp := false
			if tc.reportedPodDeletionTimestamp != nil {
				podDeletionTimestamp = tc.reportedPodDeletionTimestamp[i]
			}

			podName := fmt.Sprintf("%s-%d", podNamePrefix, i)

			reportedCPURequest := resource.MustParse("1.0")
			if specifiedCPURequests {
				reportedCPURequest = tc.reportedCPURequests[i]
			}

			pod := v1.Pod{
				Status: v1.PodStatus{
					Phase: podPhase,
					Conditions: []v1.PodCondition{
						{
							Type:               v1.PodReady,
							Status:             podReadiness,
							LastTransitionTime: podStartTime,
						},
					},
					StartTime: &podStartTime,
				},
				ObjectMeta: metav1.ObjectMeta{
					Name:      podName,
					Namespace: namespace,
					Labels: map[string]string{
						"name": podNamePrefix,
					},
				},

				Spec: v1.PodSpec{
					Containers: []v1.Container{
						{
							Name: "container1",
							Resources: v1.ResourceRequirements{
								Requests: v1.ResourceList{
									v1.ResourceCPU: *resource.NewMilliQuantity(reportedCPURequest.MilliValue()/2, resource.DecimalSI),
								},
							},
						},
						{
							Name: "container2",
							Resources: v1.ResourceRequirements{
								Requests: v1.ResourceList{
									v1.ResourceCPU: *resource.NewMilliQuantity(reportedCPURequest.MilliValue()/2, resource.DecimalSI),
								},
							},
						},
					},
				},
			}
			if podDeletionTimestamp {
				pod.DeletionTimestamp = &metav1.Time{Time: time.Now()}
			}
			obj.Items = append(obj.Items, pod)
		}
		return true, obj, nil
	})

	fakeClient.AddReactor("update", "horizontalpodautoscalers", func(action core.Action) (handled bool, ret runtime.Object, err error) {
		handled, obj, err := func() (handled bool, ret *autoscalingv2.HorizontalPodAutoscaler, err error) {
			tc.Lock()
			defer tc.Unlock()

			obj := action.(core.UpdateAction).GetObject().(*autoscalingv2.HorizontalPodAutoscaler)
			assert.Equal(t, namespace, obj.Namespace, "the HPA namespace should be as expected")
			assert.Equal(t, hpaName, obj.Name, "the HPA name should be as expected")
			assert.Equal(t, tc.expectedDesiredReplicas, obj.Status.DesiredReplicas, "the desired replica count reported in the object status should be as expected")
			if tc.verifyCPUCurrent {
				if utilization := findCpuUtilization(obj.Status.CurrentMetrics); assert.NotNil(t, utilization, "the reported CPU utilization percentage should be non-nil") {
					assert.Equal(t, tc.CPUCurrent, *utilization, "the report CPU utilization percentage should be as expected")
				}
			}
			actualConditions := obj.Status.Conditions
					if tc.expectedConditions == nil {
				tc.expectedConditions = statusOkWithOverrides()
			}
						for i := range actualConditions {
				actualConditions[i].Message = ""
				actualConditions[i].LastTransitionTime = metav1.Time{}
			}
			assert.Equal(t, tc.expectedConditions, actualConditions, "the status conditions should have been as expected")
			tc.statusUpdated = true
						return true, obj, nil
		}()
		if obj != nil {
			tc.processed <- obj.Name
		}
		return handled, obj, err
	})

	fakeScaleClient := &scalefake.FakeScaleClient{}
	fakeScaleClient.AddReactor("get", "replicationcontrollers", func(action core.Action) (handled bool, ret runtime.Object, err error) {
		tc.Lock()
		defer tc.Unlock()

		obj := &autoscalingv1.Scale{
			ObjectMeta: metav1.ObjectMeta{
				Name:      tc.resource.name,
				Namespace: namespace,
			},
			Spec: autoscalingv1.ScaleSpec{
				Replicas: tc.specReplicas,
			},
			Status: autoscalingv1.ScaleStatus{
				Replicas: tc.statusReplicas,
				Selector: selector,
			},
		}
		return true, obj, nil
	})

	fakeScaleClient.AddReactor("get", "deployments", func(action core.Action) (handled bool, ret runtime.Object, err error) {
		tc.Lock()
		defer tc.Unlock()

		obj := &autoscalingv1.Scale{
			ObjectMeta: metav1.ObjectMeta{
				Name:      tc.resource.name,
				Namespace: namespace,
			},
			Spec: autoscalingv1.ScaleSpec{
				Replicas: tc.specReplicas,
			},
			Status: autoscalingv1.ScaleStatus{
				Replicas: tc.statusReplicas,
				Selector: selector,
			},
		}
		return true, obj, nil
	})

	fakeScaleClient.AddReactor("get", "replicasets", func(action core.Action) (handled bool, ret runtime.Object, err error) {
		tc.Lock()
		defer tc.Unlock()

		obj := &autoscalingv1.Scale{
			ObjectMeta: metav1.ObjectMeta{
				Name:      tc.resource.name,
				Namespace: namespace,
			},
			Spec: autoscalingv1.ScaleSpec{
				Replicas: tc.specReplicas,
			},
			Status: autoscalingv1.ScaleStatus{
				Replicas: tc.statusReplicas,
				Selector: selector,
			},
		}
		return true, obj, nil
	})

	fakeScaleClient.AddReactor("update", "replicationcontrollers", func(action core.Action) (handled bool, ret runtime.Object, err error) {
		tc.Lock()
		defer tc.Unlock()

		obj := action.(core.UpdateAction).GetObject().(*autoscalingv1.Scale)
		replicas := action.(core.UpdateAction).GetObject().(*autoscalingv1.Scale).Spec.Replicas
		assert.Equal(t, tc.expectedDesiredReplicas, replicas, "the replica count of the RC should be as expected")
		tc.scaleUpdated = true
		return true, obj, nil
	})

	fakeScaleClient.AddReactor("update", "deployments", func(action core.Action) (handled bool, ret runtime.Object, err error) {
		tc.Lock()
		defer tc.Unlock()

		obj := action.(core.UpdateAction).GetObject().(*autoscalingv1.Scale)
		replicas := action.(core.UpdateAction).GetObject().(*autoscalingv1.Scale).Spec.Replicas
		assert.Equal(t, tc.expectedDesiredReplicas, replicas, "the replica count of the deployment should be as expected")
		tc.scaleUpdated = true
		return true, obj, nil
	})

	fakeScaleClient.AddReactor("update", "replicasets", func(action core.Action) (handled bool, ret runtime.Object, err error) {
		tc.Lock()
		defer tc.Unlock()

		obj := action.(core.UpdateAction).GetObject().(*autoscalingv1.Scale)
		replicas := action.(core.UpdateAction).GetObject().(*autoscalingv1.Scale).Spec.Replicas
		assert.Equal(t, tc.expectedDesiredReplicas, replicas, "the replica count of the replicaset should be as expected")
		tc.scaleUpdated = true
		return true, obj, nil
	})

	fakeWatch := watch.NewFake()
	fakeClient.AddWatchReactor("*", core.DefaultWatchReactor(fakeWatch, nil))

	fakeMetricsClient := &metricsfake.Clientset{}
	fakeMetricsClient.AddReactor("list", "pods", func(action core.Action) (handled bool, ret runtime.Object, err error) {
		tc.Lock()
		defer tc.Unlock()

		metrics := &metricsapi.PodMetricsList{}
		for i, cpu := range tc.reportedLevels {
						podMetric := metricsapi.PodMetrics{
				ObjectMeta: metav1.ObjectMeta{
					Name:      fmt.Sprintf("%s-%d", podNamePrefix, i),
					Namespace: namespace,
					Labels:    labelSet,
				},
				Timestamp: metav1.Time{Time: time.Now()},
				Window:    metav1.Duration{Duration: time.Minute},
				Containers: []metricsapi.ContainerMetrics{
					{
						Name: "container1",
						Usage: v1.ResourceList{
							v1.ResourceCPU: *resource.NewMilliQuantity(
								int64(cpu/2),
								resource.DecimalSI),
							v1.ResourceMemory: *resource.NewQuantity(
								int64(1024*1024/2),
								resource.BinarySI),
						},
					},
					{
						Name: "container2",
						Usage: v1.ResourceList{
							v1.ResourceCPU: *resource.NewMilliQuantity(
								int64(cpu/2),
								resource.DecimalSI),
							v1.ResourceMemory: *resource.NewQuantity(
								int64(1024*1024/2),
								resource.BinarySI),
						},
					},
				},
			}
			metrics.Items = append(metrics.Items, podMetric)
		}

		return true, metrics, nil
	})

	fakeCMClient := &cmfake.FakeCustomMetricsClient{}
	fakeCMClient.AddReactor("get", "*", func(action core.Action) (handled bool, ret runtime.Object, err error) {
		tc.Lock()
		defer tc.Unlock()

		getForAction, wasGetFor := action.(cmfake.GetForAction)
		if !wasGetFor {
			return true, nil, fmt.Errorf("expected a get-for action, got %v instead", action)
		}

		if getForAction.GetName() == "*" {
			metrics := &cmapi.MetricValueList{}

						assert.Equal(t, "pods", getForAction.GetResource().Resource, "the type of object that we requested multiple metrics for should have been pods")
			assert.Equal(t, "qps", getForAction.GetMetricName(), "the metric name requested should have been qps, as specified in the metric spec")

			for i, level := range tc.reportedLevels {
				podMetric := cmapi.MetricValue{
					DescribedObject: v1.ObjectReference{
						Kind:      "Pod",
						Name:      fmt.Sprintf("%s-%d", podNamePrefix, i),
						Namespace: namespace,
					},
					Timestamp: metav1.Time{Time: time.Now()},
					Metric: cmapi.MetricIdentifier{
						Name: "qps",
					},
					Value: *resource.NewMilliQuantity(int64(level), resource.DecimalSI),
				}
				metrics.Items = append(metrics.Items, podMetric)
			}

			return true, metrics, nil
		}

		name := getForAction.GetName()
		mapper := testrestmapper.TestOnlyStaticRESTMapper(legacyscheme.Scheme)
		metrics := &cmapi.MetricValueList{}
		var matchedTarget *autoscalingv2.MetricSpec
		for i, target := range tc.metricsTarget {
			if target.Type == autoscalingv2.ObjectMetricSourceType && name == target.Object.DescribedObject.Name {
				gk := schema.FromAPIVersionAndKind(target.Object.DescribedObject.APIVersion, target.Object.DescribedObject.Kind).GroupKind()
				mapping, err := mapper.RESTMapping(gk)
				if err != nil {
					t.Logf("unable to get mapping for %s: %v", gk.String(), err)
					continue
				}
				groupResource := mapping.Resource.GroupResource()

				if getForAction.GetResource().Resource == groupResource.String() {
					matchedTarget = &tc.metricsTarget[i]
				}
			}
		}
		assert.NotNil(t, matchedTarget, "this request should have matched one of the metric specs")
		assert.Equal(t, "qps", getForAction.GetMetricName(), "the metric name requested should have been qps, as specified in the metric spec")

		metrics.Items = []cmapi.MetricValue{
			{
				DescribedObject: v1.ObjectReference{
					Kind:       matchedTarget.Object.DescribedObject.Kind,
					APIVersion: matchedTarget.Object.DescribedObject.APIVersion,
					Name:       name,
				},
				Timestamp: metav1.Time{Time: time.Now()},
				Metric: cmapi.MetricIdentifier{
					Name: "qps",
				},
				Value: *resource.NewMilliQuantity(int64(tc.reportedLevels[0]), resource.DecimalSI),
			},
		}

		return true, metrics, nil
	})

	fakeEMClient := &emfake.FakeExternalMetricsClient{}

	fakeEMClient.AddReactor("list", "*", func(action core.Action) (handled bool, ret runtime.Object, err error) {
		tc.Lock()
		defer tc.Unlock()

		listAction, wasList := action.(core.ListAction)
		if !wasList {
			return true, nil, fmt.Errorf("expected a list action, got %v instead", action)
		}

		metrics := &emapi.ExternalMetricValueList{}

		assert.Equal(t, "qps", listAction.GetResource().Resource, "the metric name requested should have been qps, as specified in the metric spec")

		for _, level := range tc.reportedLevels {
			metric := emapi.ExternalMetricValue{
				Timestamp:  metav1.Time{Time: time.Now()},
				MetricName: "qps",
				Value:      *resource.NewMilliQuantity(int64(level), resource.DecimalSI),
			}
			metrics.Items = append(metrics.Items, metric)
		}

		return true, metrics, nil
	})

	return fakeClient, fakeMetricsClient, fakeCMClient, fakeEMClient, fakeScaleClient
}




func TestMultipleHPAs(t *testing.T) {
	const hpaCount = 1000
	const testNamespace = "dummy-namespace"

	processed := make(chan string, hpaCount)

	testClient := &fake.Clientset{}
	testScaleClient := &scalefake.FakeScaleClient{}
	testMetricsClient := &metricsfake.Clientset{}

	hpaList := [hpaCount]autoscalingv2.HorizontalPodAutoscaler{}
	scaleUpEventsMap := map[string][]timestampedScaleEvent{}
	scaleDownEventsMap := map[string][]timestampedScaleEvent{}
	scaleList := map[string]*autoscalingv1.Scale{}
	podList := map[string]*v1.Pod{}

	var minReplicas int32 = 1
	var cpuTarget int32 = 10

		for i := 0; i < hpaCount; i++ {
		hpaName := fmt.Sprintf("dummy-hpa-%v", i)
		deploymentName := fmt.Sprintf("dummy-target-%v", i)
		labelSet := map[string]string{"name": deploymentName}
		selector := labels.SelectorFromSet(labelSet).String()

				h := autoscalingv2.HorizontalPodAutoscaler{
			ObjectMeta: metav1.ObjectMeta{
				Name:      hpaName,
				Namespace: testNamespace,
			},
			Spec: autoscalingv2.HorizontalPodAutoscalerSpec{
				ScaleTargetRef: autoscalingv2.CrossVersionObjectReference{
					APIVersion: "apps/v1",
					Kind:       "Deployment",
					Name:       deploymentName,
				},
				MinReplicas: &minReplicas,
				MaxReplicas: 10,
				Behavior: &autoscalingv2.HorizontalPodAutoscalerBehavior{
					ScaleUp:   generateScalingRules(100, 60, 0, 0, 0),
					ScaleDown: generateScalingRules(2, 60, 1, 60, 300),
				},
				Metrics: []autoscalingv2.MetricSpec{
					{
						Type: autoscalingv2.ResourceMetricSourceType,
						Resource: &autoscalingv2.ResourceMetricSource{
							Name: v1.ResourceCPU,
							Target: autoscalingv2.MetricTarget{
								Type:               autoscalingv2.UtilizationMetricType,
								AverageUtilization: &cpuTarget,
							},
						},
					},
				},
			},
			Status: autoscalingv2.HorizontalPodAutoscalerStatus{
				CurrentReplicas: 1,
				DesiredReplicas: 5,
				LastScaleTime:   &metav1.Time{Time: time.Now()},
			},
		}
		hpaList[i] = h

				scaleList[deploymentName] = &autoscalingv1.Scale{
			ObjectMeta: metav1.ObjectMeta{
				Name:      deploymentName,
				Namespace: testNamespace,
			},
			Spec: autoscalingv1.ScaleSpec{
				Replicas: 1,
			},
			Status: autoscalingv1.ScaleStatus{
				Replicas: 1,
				Selector: selector,
			},
		}

				cpuRequest := resource.MustParse("1.0")
		pod := v1.Pod{
			Status: v1.PodStatus{
				Phase: v1.PodRunning,
				Conditions: []v1.PodCondition{
					{
						Type:   v1.PodReady,
						Status: v1.ConditionTrue,
					},
				},
				StartTime: &metav1.Time{Time: time.Now().Add(-10 * time.Minute)},
			},
			ObjectMeta: metav1.ObjectMeta{
				Name:      fmt.Sprintf("%s-0", deploymentName),
				Namespace: testNamespace,
				Labels:    labelSet,
			},

			Spec: v1.PodSpec{
				Containers: []v1.Container{
					{
						Name: "container1",
						Resources: v1.ResourceRequirements{
							Requests: v1.ResourceList{
								v1.ResourceCPU: *resource.NewMilliQuantity(cpuRequest.MilliValue()/2, resource.DecimalSI),
							},
						},
					},
					{
						Name: "container2",
						Resources: v1.ResourceRequirements{
							Requests: v1.ResourceList{
								v1.ResourceCPU: *resource.NewMilliQuantity(cpuRequest.MilliValue()/2, resource.DecimalSI),
							},
						},
					},
				},
			},
		}
		podList[deploymentName] = &pod

		scaleUpEventsMap[fmt.Sprintf("%s/%s", testNamespace, hpaName)] = generateEventsUniformDistribution([]int{8, 12, 9, 11}, 120)
		scaleDownEventsMap[fmt.Sprintf("%s/%s", testNamespace, hpaName)] = generateEventsUniformDistribution([]int{10, 10, 10}, 120)
	}

	testMetricsClient.AddReactor("list", "pods", func(action core.Action) (handled bool, ret runtime.Object, err error) {
		podNamePrefix := ""
		labelSet := map[string]string{}

				selector := action.(core.ListAction).GetListRestrictions().Labels
		parsedSelector := strings.Split(selector.String(), "=")
		if len(parsedSelector) > 1 {
			labelSet[parsedSelector[0]] = parsedSelector[1]
			podNamePrefix = parsedSelector[1]
		}

		podMetric := metricsapi.PodMetrics{
			ObjectMeta: metav1.ObjectMeta{
				Name:      fmt.Sprintf("%s-0", podNamePrefix),
				Namespace: testNamespace,
				Labels:    labelSet,
			},
			Timestamp: metav1.Time{Time: time.Now()},
			Window:    metav1.Duration{Duration: time.Minute},
			Containers: []metricsapi.ContainerMetrics{
				{
					Name: "container1",
					Usage: v1.ResourceList{
						v1.ResourceCPU: *resource.NewMilliQuantity(
							int64(200),
							resource.DecimalSI),
						v1.ResourceMemory: *resource.NewQuantity(
							int64(1024*1024/2),
							resource.BinarySI),
					},
				},
				{
					Name: "container2",
					Usage: v1.ResourceList{
						v1.ResourceCPU: *resource.NewMilliQuantity(
							int64(300),
							resource.DecimalSI),
						v1.ResourceMemory: *resource.NewQuantity(
							int64(1024*1024/2),
							resource.BinarySI),
					},
				},
			},
		}
		metrics := &metricsapi.PodMetricsList{}
		metrics.Items = append(metrics.Items, podMetric)

		return true, metrics, nil
	})

	metricsClient := metrics.NewRESTMetricsClient(
		testMetricsClient.MetricsV1beta1(),
		&cmfake.FakeCustomMetricsClient{},
		&emfake.FakeExternalMetricsClient{},
	)

	testScaleClient.AddReactor("get", "deployments", func(action core.Action) (handled bool, ret runtime.Object, err error) {
		deploymentName := action.(core.GetAction).GetName()
		obj := scaleList[deploymentName]
		return true, obj, nil
	})

	testClient.AddReactor("list", "pods", func(action core.Action) (handled bool, ret runtime.Object, err error) {
		obj := &v1.PodList{}

				selector := action.(core.ListAction).GetListRestrictions().Labels
		parsedSelector := strings.Split(selector.String(), "=")
		if len(parsedSelector) > 1 {
			obj.Items = append(obj.Items, *podList[parsedSelector[1]])
		} else {
						for _, p := range podList {
				obj.Items = append(obj.Items, *p)
			}
		}

		return true, obj, nil
	})

	testClient.AddReactor("list", "horizontalpodautoscalers", func(action core.Action) (handled bool, ret runtime.Object, err error) {
		obj := &autoscalingv2.HorizontalPodAutoscalerList{
			Items: hpaList[:],
		}
		return true, obj, nil
	})

	testClient.AddReactor("update", "horizontalpodautoscalers", func(action core.Action) (handled bool, ret runtime.Object, err error) {
		handled, obj, err := func() (handled bool, ret *autoscalingv2.HorizontalPodAutoscaler, err error) {
			obj := action.(core.UpdateAction).GetObject().(*autoscalingv2.HorizontalPodAutoscaler)
			assert.Equal(t, testNamespace, obj.Namespace, "the HPA namespace should be as expected")

			return true, obj, nil
		}()
		processed <- obj.Name

		return handled, obj, err
	})

	informerFactory := informers.NewSharedInformerFactory(testClient, controller.NoResyncPeriodFunc())

	hpaController := NewHorizontalController(
		testClient.CoreV1(),
		testScaleClient,
		testClient.AutoscalingV2(),
		testrestmapper.TestOnlyStaticRESTMapper(legacyscheme.Scheme),
		metricsClient,
		informerFactory.Autoscaling().V2().HorizontalPodAutoscalers(),
		informerFactory.Core().V1().Pods(),
		100*time.Millisecond,
		5*time.Minute,
		defaultTestingTolerance,
		defaultTestingCPUInitializationPeriod,
		defaultTestingDelayOfInitialReadinessStatus,
	)
	hpaController.scaleUpEvents = scaleUpEventsMap
	hpaController.scaleDownEvents = scaleDownEventsMap

	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()
	informerFactory.Start(ctx.Done())
	go hpaController.Run(ctx, 5)

	timeoutTime := time.After(15 * time.Second)
	timeout := false
	processedHPA := make(map[string]bool)
	for timeout == false && len(processedHPA) < hpaCount {
		select {
		case hpaName := <-processed:
			processedHPA[hpaName] = true
		case <-timeoutTime:
			timeout = true
		}
	}

	assert.Equal(t, hpaCount, len(processedHPA), "Expected to process all HPAs")
}

func TestPartialBehaviors(t *testing.T) {

	t.Run("ensure no panic if scaleDown rules are missing", func(t *testing.T) {
		tc := testCase{
			minReplicas:             2,
			maxReplicas:             6,
			specReplicas:            3,
			statusReplicas:          3,
			expectedDesiredReplicas: 5,
			CPUTarget:               30,
			verifyCPUCurrent:        true,
			reportedLevels:          []uint64{300, 500, 700},
			reportedCPURequests:     []resource.Quantity{resource.MustParse("1.0"), resource.MustParse("1.0"), resource.MustParse("1.0")},
			useMetricsAPI:           true,
			scaleUpRules:            autoscalingapiv2.GenerateHPAScaleUpRules(nil),
		}
		tc.runTest(t)
	})

	t.Run("ensure no panic if scaleUp rules are missing", func(t *testing.T) {
		tc := testCase{
			minReplicas:             2,
			maxReplicas:             6,
			specReplicas:            5,
			statusReplicas:          5,
			expectedDesiredReplicas: 3,
			CPUTarget:               50,
			verifyCPUCurrent:        true,
			reportedLevels:          []uint64{100, 300, 500, 250, 250},
			reportedCPURequests:     []resource.Quantity{resource.MustParse("1.0"), resource.MustParse("1.0"), resource.MustParse("1.0"), resource.MustParse("1.0"), resource.MustParse("1.0")},
			useMetricsAPI:           true,
			recommendations:         []timestampedRecommendation{},
			scaleDownRules:          autoscalingapiv2.GenerateHPAScaleDownRules(nil),
		}
		tc.runTest(t)
	})
}

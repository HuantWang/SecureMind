func (i *ImageService) ImageHistory(ctx context.Context, name string) ([]*image.HistoryResponseItem, error) {
	start := time.Now()
	img, err := i.GetImage(ctx, name, backend.GetImageOpts{})
	if err != nil {
		return nil, err
	}

	history := []*image.HistoryResponseItem{}

	layerCounter := 0
	rootFS := *img.RootFS
	rootFS.DiffIDs = nil

	for _, h := range img.History {
		var layerSize int64

		if !h.EmptyLayer {
			if len(img.RootFS.DiffIDs) <= layerCounter {
				return nil, fmt.Errorf("too many non-empty layers in History section")
			}
			rootFS.Append(img.RootFS.DiffIDs[layerCounter])
			l, err := i.layerStore.Get(rootFS.ChainID())
			if err != nil {
				return nil, err
			}
			layerSize = l.DiffSize()
			layer.ReleaseAndLog(i.layerStore, l)
			layerCounter++
		}

		var created int64
		if h.Created != nil {
			created = h.Created.Unix()
		}

		history = append([]*image.HistoryResponseItem{{
			ID:        "<missing>",
			Created:   created,
			CreatedBy: h.CreatedBy,
			Comment:   h.Comment,
			Size:      layerSize,
		}}, history...)
	}

		histImg := img
	id := img.ID()
	for _, h := range history {
		h.ID = id.String()

		var tags []string
		for _, r := range i.referenceStore.References(id.Digest()) {
			if _, ok := r.(reference.NamedTagged); ok {
				tags = append(tags, reference.FamiliarString(r))
			}
		}

		h.Tags = tags

		id = histImg.Parent
		if id == "" {
			break
		}
		histImg, err = i.GetImage(ctx, id.String(), backend.GetImageOpts{})
		if err != nil {
			break
		}
	}
	ImageActions.WithValues("history").UpdateSince(start)
	return history, nil
}

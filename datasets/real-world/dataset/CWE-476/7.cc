void CropInferMeta(const MetaTensor& x,
                   const IntArray& shape,
                   const IntArray& offsets,
                   MetaTensor* out,
                   MetaConfig config) {
  PADDLE_ENFORCE_NE(
      out,
      nullptr,
      errors::InvalidArgument("CropTensor should have output tensor out."));

  auto x_dim = x.dims();
  auto shape_dims = shape.GetData();
  auto offsets_vec = offsets.GetData();

  PADDLE_ENFORCE_EQ(shape_dims.size(),
                    x_dim.size(),
                    errors::InvalidArgument(
                        "The number of elements (%d) of attribute 'shape' for "
                        "CropTensor must be equal to the number of "
                        "dimensions (%d) of the input.",
                        shape_dims.size(),
                        x_dim.size()));

  if (config.is_runtime) {
    out->share_lod(x);
  }

  auto out_dims = std::vector<int64_t>(shape.size(), -1);
  for (int i = 0; i < static_cast<int>(shape_dims.size()); ++i) {
    if (shape_dims[i] > 0) {
      out_dims[i] = static_cast<int64_t>(shape_dims[i]);
    } else {
      if (shape_dims[i] == -1 && offsets_vec[i] != -1 && x_dim[i] != -1) {
        out_dims[i] = x_dim[i] - static_cast<int64_t>(offsets_vec[i]);
      }
    }
  }
  out->set_dims(common::make_ddim(out_dims));
  out->set_dtype(x.dtype());
}
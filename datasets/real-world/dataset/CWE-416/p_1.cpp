bool fastly_compute_at_edge_http_req_downstream_tls_cipher_openssl_name(
    fastly_world_string_t *ret, fastly_compute_at_edge_types_error_t *err)
{
  auto default_size = 128;
  ret->ptr = static_cast<uint8_t *>(cabi_malloc(default_size, 4));
  auto status = fastly::req_downstream_tls_cipher_openssl_name(reinterpret_cast<char *>(ret->ptr),
                                                               default_size, &ret->len);
  if (status == FASTLY_COMPUTE_AT_EDGE_TYPES_ERROR_BUFFER_LEN)
  {
    ret->ptr = static_cast<uint8_t *>(cabi_realloc(ret->ptr, default_size, 4, ret->len));
    status = fastly::req_downstream_tls_cipher_openssl_name(reinterpret_cast<char *>(ret->ptr),
                                                            ret->len, &ret->len);
  }
  return convert_result(status, err);
}

bool fastly_compute_at_edge_http_req_downstream_tls_protocol(
    fastly_world_string_t *ret, fastly_compute_at_edge_types_error_t *err)
{
  auto default_size = 32;
  ret->ptr = static_cast<uint8_t *>(cabi_malloc(default_size, 4));
  auto status = fastly::req_downstream_tls_protocol(reinterpret_cast<char *>(ret->ptr),
                                                    default_size, &ret->len);
  if (status == FASTLY_COMPUTE_AT_EDGE_TYPES_ERROR_BUFFER_LEN)
  {
    ret->ptr = static_cast<uint8_t *>(cabi_realloc(ret->ptr, default_size, 4, ret->len));
    status = fastly::req_downstream_tls_protocol(reinterpret_cast<char *>(ret->ptr), ret->len,
                                                 &ret->len);
  }
  return convert_result(status, err);
}

bool fastly_compute_at_edge_http_req_downstream_tls_raw_client_certificate(
    fastly_world_list_u8_t *ret, fastly_compute_at_edge_types_error_t *err)
{
  auto default_size = 4096;
  ret->ptr = static_cast<uint8_t *>(cabi_malloc(default_size, 4));
  auto status =
      fastly::req_downstream_tls_raw_client_certificate(ret->ptr, default_size, &ret->len);
  if (status == FASTLY_COMPUTE_AT_EDGE_TYPES_ERROR_BUFFER_LEN)
  {
    ret->ptr = static_cast<uint8_t *>(cabi_realloc(ret->ptr, default_size, 4, ret->len));
    status = fastly::req_downstream_tls_raw_client_certificate(ret->ptr, ret->len, &ret->len);
  }
  return convert_result(status, err);
}

bool fastly_compute_at_edge_http_req_downstream_tls_ja3_md5(
    fastly_world_list_u8_t *ret, fastly_compute_at_edge_types_error_t *err)
{
  auto default_size = 16;
  ret->ptr = static_cast<uint8_t *>(cabi_malloc(default_size, 4));
  auto status = fastly::req_downstream_tls_ja3_md5(ret->ptr, &ret->len);
  if (status == FASTLY_COMPUTE_AT_EDGE_TYPES_ERROR_BUFFER_LEN)
  {
    ret->ptr = static_cast<uint8_t *>(cabi_realloc(ret->ptr, default_size, 4, ret->len));
    status = fastly::req_downstream_tls_ja3_md5(ret->ptr, &ret->len);
  }
  return convert_result(status, err);
}

bool fastly_compute_at_edge_http_req_downstream_tls_client_hello(
    fastly_world_list_u8_t *ret, fastly_compute_at_edge_types_error_t *err)
{
  auto default_size = 512;
  ret->ptr = static_cast<uint8_t *>(cabi_malloc(default_size, 4));
  auto status = fastly::req_downstream_tls_client_hello(ret->ptr, default_size, &ret->len);
  if (status == FASTLY_COMPUTE_AT_EDGE_TYPES_ERROR_BUFFER_LEN)
  {
    ret->ptr = static_cast<uint8_t *>(cabi_realloc(ret->ptr, default_size, 4, ret->len));
    status = fastly::req_downstream_tls_client_hello(ret->ptr, ret->len, &ret->len);
  }
  return convert_result(status, err);
}

bool fastly_compute_at_edge_cache_get_user_metadata(fastly_compute_at_edge_cache_handle_t handle,
                                                    fastly_world_list_u8_t *ret,
                                                    fastly_compute_at_edge_cache_error_t *err)
{
  size_t default_size = 16 * 1024;
  ret->ptr = static_cast<uint8_t *>(cabi_malloc(default_size, 4));
  auto status = fastly::cache_get_user_metadata(handle, reinterpret_cast<char *>(ret->ptr),
                                                default_size, &ret->len);
  if (status == FASTLY_COMPUTE_AT_EDGE_TYPES_ERROR_BUFFER_LEN)
  {
    ret->ptr = static_cast<uint8_t *>(cabi_realloc(ret->ptr, default_size, 4, ret->len));
    status = fastly::cache_get_user_metadata(handle, reinterpret_cast<char *>(ret->ptr), ret->len,
                                             &ret->len);
  }
  return convert_result(status, err);
}

bool fastly_compute_at_edge_device_detection_lookup(
    fastly_world_string_t *user_agent, fastly_world_string_t *ret,
    fastly_compute_at_edge_device_detection_error_t *err)
{
  auto default_size = 1024;
  ret->ptr = static_cast<uint8_t *>(cabi_malloc(default_size, 4));
  auto status =
      fastly::device_detection_lookup(reinterpret_cast<char *>(user_agent->ptr), user_agent->len,
                                      reinterpret_cast<char *>(ret->ptr), default_size, &ret->len);
  if (status == FASTLY_COMPUTE_AT_EDGE_TYPES_ERROR_BUFFER_LEN)
  {
    ret->ptr = static_cast<uint8_t *>(cabi_realloc(ret->ptr, default_size, 4, ret->len));
    status =
        fastly::device_detection_lookup(reinterpret_cast<char *>(user_agent->ptr), user_agent->len,
                                        reinterpret_cast<char *>(ret->ptr), ret->len, &ret->len);
  }
  return convert_result(status, err);
}
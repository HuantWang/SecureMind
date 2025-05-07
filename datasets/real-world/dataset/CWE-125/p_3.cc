#include "onnx/common/assertions.h"

#include <array>
#include <cstdarg>
#include <cstdio>

#include "onnx/common/common.h"

std::string barf(const char *fmt, ...)
{
  constexpr size_t buffer_size = 2048;
  std::array<char, buffer_size> msg{};
  va_list args;

  va_start(args, fmt);

  vsnprintf(static_cast<char *>(msg.data()), msg.size() - 1, fmt, args);

  msg.back() = '\0';
  va_end(args);

  return std::string(msg.data());
}
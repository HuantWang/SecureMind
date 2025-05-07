#include "onnx/common/assertions.h"

#include <cstdarg>
#include <cstdio>

#include "onnx/common/common.h"

std::string barf(const char *fmt, ...)
{
  char msg[2048];
  va_list args;

  va_start(args, fmt);
  vsnprintf(msg, 2048, fmt, args);
  va_end(args);

  return std::string(msg);
}
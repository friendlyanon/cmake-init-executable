#include "lib.hpp"

auto main() -> int
{
  auto const lib = library {};

  return lib.name == "executable" ? 0 : 1;
}

#include "lib.hpp"

auto main() -> int
{
  library lib;

  return lib.name == "executable" ? 0 : 1;
}

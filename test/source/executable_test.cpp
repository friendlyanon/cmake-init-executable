#include <lib.h>

auto main() -> int
{
  library lib;

  return lib.name == "executable" ? 0 : 1;
}

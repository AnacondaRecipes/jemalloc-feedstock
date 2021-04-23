#define JEMALLOC_NO_DEMANGLE
#include <jemalloc/jemalloc.h>

int main() {
  void* a = je_aligned_alloc(4, 16);
  je_free(a);
}

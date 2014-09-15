#ifndef TESTS_DUMMY_HXX
# define TESTS_DUMMY_HXX

# include "dummy.hh"

template <typename T>
__device__ void foo (T* a)
{
  a[0] = 42;
}

template <typename T>
void bar (T* a)
{
  a[0] = 42;
}

#endif //! TESTS_DUMMY_HXX

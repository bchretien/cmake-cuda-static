#include "dummy.hh"
#include "dummy.hxx"

// Explicit instantiation
template
__device__ void foo<int> (int* v);

template
void bar<int> (int* v);

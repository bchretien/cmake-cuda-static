#include "dummy.hh"

#include <stdio.h>
#include <iostream>

__global__ void dummy (int* v)
{
  // Calling a device function in a device function
  // fails with: "nvlink error: Undefined reference to ..."
  // if not compiled with the appropriate commands.
  v[0] = 0;
  foo (v);
  printf ("%i\n", v[0]);
}

int main()
{
  int* v;
  cudaMalloc (&v, 4 * sizeof (int));
  dummy<<<1,1>>> (v);
  cudaFree (v);

  int* u;
  u = (int*) malloc (4 * sizeof (int));

  // Calling the following host function works as expected
  bar (u);
  std::cout << u[0] << std::endl;

  // Calling a device function in a host function fails
  // as expected (detected by the compiler):
  // error: calling a __device__ function("foo") from a
  // __host__ function("main") is not allowed
  //foo (u);

  free (u);

  return 0;
}

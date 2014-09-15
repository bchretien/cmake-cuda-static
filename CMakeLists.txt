CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

# Require CUDA >= 5.0
FIND_PACKAGE(CUDA 5.0 REQUIRED)

SET(CUDA_CC "30" CACHE STRING "CUDA Compute Capability of the target GPU.")
SET(CUDA_NVCC_FLAGS
  "${CUDA_NVCC_FLAGS};-gencode;arch=compute_${CUDA_CC},code=sm_${CUDA_CC};")
SET(CUDA_NVCC_FLAGS "${CUDA_NVCC_FLAGS};-Xcompiler;-fPIC")

# Disable warnings for CUDA
SET(CUDA_NVCC_FLAGS "${CUDA_NVCC_FLAGS};-w")

SET(CUDA_SEPARABLE_COMPILATION OFF)
SET(CUDA_NVCC_FLAGS "${CUDA_NVCC_FLAGS};-rdc=true")

# Note: only static libraries are supported by the device linker.
SET(BUILD_SHARED_LIBS OFF)

ADD_SUBDIRECTORY(src)

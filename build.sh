#!/bin/sh -x
# Equivalent shell script (for testing).

NVCC_ARGS="-arch=sm_30"
EXE_SRC="src/dummy_exe.cu"
LIB_SRC="src/dummy.cu"

LIB_BASE=$(basename "${LIB_SRC}")
LIB_NAME="${LIB_BASE%.*}"
LIB_STATIC="${LIB_NAME}.a"
LIB_OBJ="${LIB_NAME}.o"

EXE_BASE=$(basename "${EXE_SRC}")
EXE_NAME="${EXE_BASE%.*}"
EXE_OBJ="${EXE_NAME}.o"

# To try and use CMake-generated libdummy.a
#CMAKE_LIB_STATIC=build/src/libdummy.a

rm ${LIB_OBJ} ${LIB_STATIC} ${EXE_OBJ} ${EXE_NAME}

# Static library containing relocatable device code
if [ -n "${CMAKE_LIB_STATIC}" ]; then
  LIB_STATIC=${CMAKE_LIB_STATIC}
else
  nvcc ${NVCC_ARGS} -dc ${LIB_SRC} -o ${LIB_OBJ}
  nvcc -lib ${LIB_OBJ} -o ${LIB_STATIC}
fi


# Make executable and link with static library
nvcc ${NVCC_ARGS} -dlink ${LIB_STATIC} -c ${EXE_SRC}
nvcc ${NVCC_ARGS} ${LIB_STATIC} ${EXE_OBJ} -o ${EXE_NAME}

./${EXE_NAME}

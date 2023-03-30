#!/bin/bash
#---------------------------------------------------------------------------------------------------------------------#
echo -e "________________________ Building PG Math Libraries  ______________________"
echo -e ""

SOURCE_DIR=${PGMATH_HOME}

if [ -d ${PGMATH_BUILD} ]; then
	rm -rf ${PGMATH_BUILD}
fi

mkdir -p ${PGMATH_BUILD}
cd ${PGMATH_BUILD}

cmake -G "Unix Makefiles" \
  -DCMAKE_BUILD_TYPE="Release" \
  -DLLVM_ENABLE_ASSERTIONS="ON" \
  -DCMAKE_SHARED_LINKER_FLAGS='-Wl,--disable-new-dtags' \
  -DCMAKE_INSTALL_RPATH_USE_LINK_PATH="ON" \
  -DLLVM_CONFIG=${ROCM_PATH}/bin/llvm-config \
  -DCMAKE_C_COMPILER=gcc \
  -DCMAKE_CXX_COMPILER=g++ \
  -DCMAKE_INSTALL_PREFIX=${INSTALL_HOME} \
  -DLLVM_TARGETS_TO_BUILD="AMDGPU;X86" \
  -DCMAKE_C_FLAGS="-I$ROCM_PATH/clang/16.0.0/include -I/home/ampandey/rocm-toolchain/staging/src-home/flang/runtime/include" \
  -DCMAKE_CXX_FLAGS="-I$ROCM_PATH/clang/16.0.0/include -I/home/ampandey/rocm-toolchain/staging/src-home/flang/runtime/include"\
  ${SOURCE_DIR}


make -j$(nproc)
make -j$(nproc) install
#(set -x; cmake -G "Unix Makefiles" ${CMAKE_OPTIONS[@]} ${SOURCE_DIR}; make -j8; make -j8 install)

cd $WORK_DIR/scripts

#---------------------------------------------------------------------------------------------------------------------#

echo -e "________________________ Building Flang Compiler && Flang Runtime  ______________________"
echo -e ""

## Build the Flang Compiler

echo -e "Started building Flang Compiler...."
SOURCE_DIR=${FLANG_HOME}

if [ -d ${FLANG_BUILD} ]; then
	rm -rf ${FLANG_BUILD}
fi

mkdir -p ${FLANG_BUILD}
cd ${FLANG_BUILD}

CMAKE_OPTIONS_COMPILER=(
  -DCMAKE_C_COMPILER="clang"
  -DCMAKE_CXX_COMPILER="clang++"
  -DCMAKE_C_FLAGS="-I$FLANG_HOME/runtime/libpgmath/lib/common"
  -DCMAKE_CXX_FLAGS="-I$FLANG_HOME/runtime/libpgmath/lib/common"
  -DLLVM_ENABLE_ASSERTIONS="ON"
  -DLLVM_CONFIG="$ROCM_PATH/llvm/bin/llvm-config"
  -DCMAKE_Fortran_COMPILER="gfortran"
  -DLLVM_TARGETS_TO_BUILD="AMDGPU;X86"
  -DFLANG_OPENMP_GPU_AMD="ON"
  -DFLANG_OPENMP_GPU_NVIDIA="ON"
  -DLLVM_INSTALL_TOOLCHAIN_ONLY="ON"
	--trace-expand
  -DFLANG_INCLUDE_TESTS="OFF"
  -DCMAKE_BUILD_TYPE="Release"
	-DWITH_WERROR=OFF
  -DCMAKE_INSTALL_PREFIX=${INSTALL_HOME}
)

(set -x; cmake -G "Unix Makefiles" ${CMAKE_OPTIONS_COMPILER[@]} ${SOURCE_DIR}; make -j$(nproc); make -j$(nproc) install)

echo -e "Flang Compiler Build Successfull!"

#---------------------------------------------------------------------------------------------------------------------#

#---------------------------------------------------------------------------------------------------------------------#
## Build the Flang Runtime
echo -e "Started building Flang Runtime...."
export FC="$ROCM_PATH/llvm/bin/flang"
SOURCE_DIR=${FLANG_HOME}

if [ -d ${FLANGRT_BUILD} ]; then
	rm -rf ${FLANGRT_BUILD}
fi

mkdir -p ${FLANGRT_BUILD}
cd ${FLANGRT_BUILD}

cmake -G "Unix Makefiles" \
	-DCMAKE_C_COMPILER="clang" \
	-DCMAKE_CXX_COMPILER="clang++" \
	-DCMAKE_C_FLAGS="-I$FLANG_HOME/runtime/libpgmath/lib/common" \
	-DCMAKE_CXX_FLAGS="-I$FLANG_HOME/runtime/libpgmath/lib/common" \
	-DLLVM_ENABLE_ASSERTIONS="ON" \
	-DLLVM_DIR="$LLVM_BUILD" \
	-DLLVM_INSTALL_RUNTIME="ON" \
	-DLLVM_CONFIG="$ROCM_PATH/llvm/bin/llvm-config" \
	-DCMAKE_Fortran_COMPILER="flang" \
	-DCMAKE_TARGETS_TO_BUILD="AMDGPU;X86" \
	-DFLANG_BUILD_RUNTIME="ON" \
	-DOPENMP_BUILD_DIR="$OPENMP_BUILD/runtime/src" \
	-DFLANG_INCLUDE_TESTS="OFF" \
	-DCMAKE_PREFIX_PATH="$PGMATH_BUILD;$FLANG_BUILD;$LLVM_BUILD" \
	-DCMAKE_BUILD_TYPE="Release" \
	-DCMAKE_INSTALL_PREFIX="$INSTALL_HOME" \
	-DCMAKE_SHARED_LINKER_FLAGS='-Wl,--disable-new-dtags' \
	${SOURCE_DIR}

#(set -x; cmake -G "Unix Makefiles" ${CMAKE_OPTIONS_RT[@]} ${SOURCE_DIR})

make -j$(nproc)
make -j$(nproc) install

echo -e "Flang Runtime Build Successfull!"
#---------------------------------------------------------------------------------------------------------------------#

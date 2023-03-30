echo -e "________________________ Building OpenMP Runtime ______________________"

SOURCE_DIR=${LLVM_HOME}/openmp

if [ -d ${OPENMP_BUILD} ]; then
rm -rf ${OPENMP_BUILD}
fi

mkdir -p ${OPENMP_BUILD}
cd ${OPENMP_BUILD}

COMPILE_FLAGS="-O0 -g"

set -x
cmake -G "Unix Makefiles" \
	-DCMAKE_C_COMPILER="clang" \
	-DCMAKE_CXX_COMPILER="clang++" \
	-DCMAKE_C_FLAGS="$COMPILE_FLAGS" \
	-DCMAKE_CXX_FLAGS="$COMPILE_FLAGS" \
	-DOPENMP_ENABLE_LIBOMPTARGET="1" \
	-DDEVICELIBS_ROOT="${DLIB_HOME}" \
	-DLIBOMPTARGET_AMDGCN_GFXLIST="gfx700;gfx701;gfx801;gfx803;gfx900;gfx902;gfx90a;gfx908;gfx906;gfx1030;gfx1031" \
	-DLIBOMPTARGET_ENABLE_DEBUG="ON" \
	-DLLVM_DIR="${LLVM_BUILD}" \
	-DLLVM_USE_LINKER="lld" \
	-DLIBOMPTARGET_INCLUDE_DIR="${LLVM_BUILD}/include" \
	-DLIBOMPTARGET_LLVM_INCLUDE_DIRS="${LLVM_HOME}/llvm/include" \
	-DCMAKE_BUILD_TYPE="Debug" \
	-DCMAKE_PREFIX_PATH="/home/ampandey/grpc-home/grpc-install;${ROCM_PATH}" \
	-DCMAKE_INSTALL_PREFIX="${INSTALL_HOME}/llvm" \
	-DSANITIZER_AMDGPU="ON" \
	$SOURCE_DIR

make -j${JOB_THREADS}
make -j${JOB_THREADS} install
#make -j${JOB_THREADS} check-openmp
set +x


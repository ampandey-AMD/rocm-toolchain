echo -e "____________________________ Building LLVM Compiler without compiler-rt  ___________________________________"
echo -e ""

SOURCE_DIR=${LLVM_HOME}/llvm

if [ -d ${LLVM_BUILD} ]; then
	rm -rf ${LLVM_BUILD}
fi

mkdir -p ${LLVM_BUILD}
cd ${LLVM_BUILD}

#COMPILE_FLAGS="-O0"

set -x
cmake -G "Unix Makefiles" \
	-DLLVM_BUILD_TOOLS="ON" \
	-DCMAKE_C_COMPILER="gcc" \
	-DCMAKE_CXX_COMPILER="g++" \
	-DCMAKE_BUILD_TYPE="Release"\
	-DLLVM_ENABLE_ASSERTIONS="ON" \
	-DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lld" \
	-DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;compiler-rt" \
	-DLLVM_ENABLE_RTTI="ON" \
	-DLLVM_PARALLEL_COMPILE_JOBS="$(nproc)" \
	-DLLVM_PARALLEL_LINK_JOBS="32" \
	-DLLVM_INSTALL_UTILS="ON" \
	-DLLVM_TARGETS_TO_BUILD="X86;AMDGPU" \
	-DCMAKE_INSTALL_PREFIX="${INSTALL_HOME}/llvm" \
	${SOURCE_DIR} \
	-DSANITIZER_AMDGPU="ON" \
	-DSANITIZER_HSA_INCLUDE_PATH="${ROCR_HOME}/opensrc/hsa-runtime/inc" \
	-DSANITIZER_COMGR_INCLUDE_PATH="${COMGR_HOME}/lib/comgr/include"
	#-DLLVM_USE_LINKER="lld" \
	#	-DCMAKE_PREFIX_PATH="${ROCM_PATH};/opt/rocm-5.5.0-99999" \
#	-DCMAKE_C_FLAGS="$COMPILE_FLAGS" \
#	-DCMAKE_CXX_FLAGS="$COMPILE_FLAGS" \

cmake --build . -- -j${JOB_THREADS} clang lld compiler-rt
cmake --build . -- -j${JOB_THREADS} runtimes cxx
cmake --build . -- -j${JOB_THREADS} install

#make -j${JOB_THREADS}
#make -j${JOB_THREADS} install
#make -j${JOB_THREADS} check-clang check-llvm check-lld
set +x

cd $WORK_DIR/scripts

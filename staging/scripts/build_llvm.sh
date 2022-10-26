echo -e "____________________________ Building LLVM Compiler with compiler-rt runtime  ___________________________________"
echo -e ""

SOURCE_DIR=${LLVM_HOME}/llvm

if [ -d ${LLVM_BUILD} ]; then
				rm -rf ${LLVM_BUILD}
fi

mkdir -p ${LLVM_BUILD}
cd ${LLVM_BUILD}

CMAKE_OPTIONS=(
				-DLLVM_BUILD_TOOLS=ON
				-DCMAKE_C_COMPILER="gcc"
				-DCMAKE_CXX_COMPILER="g++"
				-DCMAKE_BUILD_TYPE="Debug"
				-DCOMPILER_RT_DEBUG=ON
				-DLLVM_ENABLE_ASSERTIONS=ON
				-DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lld"
				-DLLVM_ENABLE_RUNTIMES="compiler-rt"
				-DLLVM_ENABLE_RTTI=ON
				-DLLVM_PARALLEL_COMPILE_JOBS=$(nproc)
				-DLLVM_PARALLEL_LINK_JOBS=32
				-DLLVM_INSTALL_UTILS=ON
				-DLLVM_TARGETS_TO_BUILD="X86;AMDGPU"
				-DCMAKE_SHARED_LINKER_FLAGS="-Wl,--disable-new-dtags"
				-DLLVM_USE_LINKER="gold"
				-DCMAKE_PREFIX_PATH="${ROCM_PATH}"
				-DCMAKE_INSTALL_PREFIX=${INSTALL_HOME}/llvm
)

if [ ! -z "$1" ] && [ "$1" == "asan" ]; then
				CMAKE_OPTIONS+=("-DSANITIZER_AMDGPU=1")
				CMAKE_OPTIONS+=("-DHSA_INCLUDE_PATH=${ROCR_HOME}/opensrc/hsa-runtime/inc")
        CMAKE_OPTIONS+=("-DCOMGR_INCLUDE_PATH=${COMGR_HOME}/lib/comgr/include")
fi


(set -x; cmake -G "Unix Makefiles" ${CMAKE_OPTIONS[@]} ${SOURCE_DIR}; make -j${JOB_THREADS}; make -j${JOB_THREADS} install)

#(set -x; cmake -G "Unix Makefiles" ${CMAKE_OPTIONS[@]} ${SOURCE_DIR}; make -j${JOB_THREADS}; make -j${JOB_THREADS} install; make -j${JOB_THREADS} check-clang ;make -j${JOB_THREADS} check-llvm)

cd $WORK_DIR/scripts
echo -e "____________________________ Building compiler-rt runtime  ___________________________________"
echo -e ""

SOURCE_DIR=${LLVM_HOME}/compiler-rt

if [ -d ${COMPILERRT_BUILD} ]; then
	rm -rf ${COMPILERRT_BUILD}
fi

mkdir -p ${COMPILERRT_BUILD}
cd ${COMPILERRT_BUILD}

CMAKE_OPTIONS=(
	-DLLVM_BUILD_TOOLS=ON
	-DCMAKE_C_COMPILER="clang"
	-DCMAKE_CXX_COMPILER="clang++"
	-DCMAKE_BUILD_TYPE="Release"
	-DLLVM_ENABLE_ASSERTIONS=ON
	#-DCOMPILER_RT_DEBUG=ON
	-DLLVM_ENABLE_RTTI=ON
	-DLLVM_PARALLEL_COMPILE_JOBS=$(nproc)
	-DLLVM_PARALLEL_LINK_JOBS=32
	-DLLVM_ENABLE_LLD=ON
	-DCMAKE_PREFIX_PATH="${ROCM_PATH}/llvm"
	-DCMAKE_INSTALL_PREFIX=${INSTALL_HOME}/llvm/lib/clang/17
)

if [ -n "$1" ] && [ "$1" == "asan-amdgpu" ]; then
	CMAKE_OPTIONS+=("-DSANITIZER_AMDGPU=1")
	CMAKE_OPTIONS+=("-DHSA_INCLUDE_PATH=${ROCR_HOME}/opensrc/hsa-runtime/inc;/opt/rocm/hsa/include")
	CMAKE_OPTIONS+=("-DCOMGR_INCLUDE_PATH=${COMGR_HOME}/lib/comgr/include;/opt/rocm/include")
fi


(set -x; cmake -G "Unix Makefiles" ${CMAKE_OPTIONS[@]} ${SOURCE_DIR}; make -j${JOB_THREADS}; make -j${JOB_THREADS} install)

#(set -x; cmake -G "Unix Makefiles" ${CMAKE_OPTIONS[@]} ${SOURCE_DIR}; make -j${JOB_THREADS}; make -j${JOB_THREADS} install; make -j${JOB_THREADS} check-clang ;make -j${JOB_THREADS} check-llvm)

cd $WORK_DIR/scripts

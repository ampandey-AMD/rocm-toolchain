export WORK_HOME=/home/ampandey/rocm-toolchain
source ${WORK_HOME}/staging/scripts/export_common_vars.sh

function enable_omp_debug(){
### OpenMP runtime flags
export LIBOMPTARGET_INFO=-1
export LIBOMPTARGET_DEBUG=1
export LIBOMPTARGET_KERNEL_TRACE=3
export LIBOMPTARGET_DEVICE_RTL_DEBUG=1
export LIBOMPDEVICE_DEBUG=1
}

function enable_hsa_debug(){
### HSA FLAGS
export HSAKMT_DEBUG_LEVEL=7
export HSA_ENABLE_SDMA=1
export HSA_ENABLE_INTERRUPT=0
export HSA_SVM_GUARD_PAGES=0
export HSA_DISABLE_CACHE=1

### ROCR DEBUG Agent Flags
export HSA_TOOLS_LIB=/opt/rocm/lib/librocm-debug-agent.so.2
export HSA_ENABLE_DEBUG=1
}

function enable_hip_debug(){
### OpenCL FLAGS
export AMD_OCL_IN_PROCESS=0
export AMD_OCL_LOG_LEVEL=3


### COMGR FLAGS
export AMD_COMGR_EMIT_VERBOSE_LOGS=1
export AMD_COMGR_SAVE_TEMPS=1

### HIP FLAGS
export AMD_LOG_LEVEL=5
export AMD_OCL_WAIT_COMMAND=1
export HIPCC_VERBOSE=7
}

if [ -n "$1" ];then
	if [ "$1" == "omp" ]; then
		enable_omp_debug
	elif [ "$1" == "hsa" ]; then
		enable_hsa_debug
	elif [ "$1" == "hip" ]; then
		enable_hip_debug
	elif [ "$1" == "all" ]; then
		enable_omp_debug
		enable_hsa_debug
		enable_hip_debug
	fi
fi

export ROCM_PATH=$INSTALL_HOME
export HSA_PATH=${ROCM_PATH}/hsa
export HIP_ROCCLR_HOME=${VDI_BUILD}
export HIP_CLANG_PATH=${ROCM_PATH}/llvm/bin
export HIP_CLANG_INCLUDE_PATH=${ROCM_PATH}/llvm/include
export HIP_INCLUDE_PATH=${ROCM_PATH}/hip/include
export HIP_LIB_PATH=${ROCM_PATH}/hip/lib
export DEVICE_LIB_PATH=${ROCM_PATH}/amdgcn/bitcode
export HIPCC_COMPILE_FLAGS_APPEND='-g'

export AOMP=$ROCM_PATH/llvm
export AOMPROCM=$ROCM_PATH
export AOMP_GPU=gfx906

export AOMP_JOB_THREADS=4
export JOB_THREADS=$(nproc)

## Note ROCM_PATH/../build/llvm/bin is added to PATH for llvm-lit binary which is not available in installed binary folder.
export PATH="$ROCM_PATH/llvm/bin:$ROCM_PATH/bin:$ROCM_PATH/../build/llvm/bin:$PATH"
export LD_LIBRARY_PATH="$ROCM_PATH/amdgcn/bitcode:$ROCM_PATH/llvm/lib:$ROCM_PATH/lib:$LD_LIBRARY_PATH"
export LIBRARY_PATH="$ROCM_PATH/amdgcn/bitcode:$ROCM_PATH/llvm/lib:$ROCM_PATH/lib:$LIBRARY_PATH"
#### ASAN FLAGS #######
#### This Flag is required for the lit test cases to run successfully for customized rocm path(i.e other than /opt/rocm) installation. ####
CLANG_VERSION=$(clang --version | grep -om 1  "[0-9]\+\.[0-9]\.[0-9]")
export ASAN_TEST_ROCM=$ROCM_PATH
export ASAN_OPTIONS="help=0:verbosity=0:symbolize=1:detect_leaks=0" #;allocator_may_return_null=1
ASAN_RT_PATH="$ROCM_PATH/lib/clang/$CLANG_VERSION/lib/linux"
#export LD_PRELOAD=$ASAN_RT_PATH/libclang_rt.asan-x86_64.so

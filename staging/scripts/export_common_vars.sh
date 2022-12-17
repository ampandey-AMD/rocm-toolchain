########################################################################################################
#### BUILD FIRST ROCT AND ROCR then BUILD LLVM DLIBS OPENMP VDI HIPAMD OPENCL #####
########################################################################################################

export WORK_DIR=${WORK_HOME}/staging
export SRC_HOME=${WORK_DIR}/src-home
export BUILD_HOME=${WORK_DIR}/build
export INSTALL_HOME=${WORK_DIR}/rocm

########################################################################################################
### SOURCE-CODE HOME
########################################################################################################
export LLVM_HOME=${SRC_HOME}/llvm-project
export COMPILERRT_HOME=${SRC_HOME}/llvm-project/compiler-rt
export DLIB_HOME=${SRC_HOME}/device-libs
export ROCR_HOME=${SRC_HOME}/rocr
export ROCT_HOME=${SRC_HOME}/roct
export VDI_HOME=${SRC_HOME}/vdi
export HIP_HOME=${SRC_HOME}/hip
export HIPAMD_HOME=${SRC_HOME}/hipamd
export OPENCL_HOME=${SRC_HOME}/opencl
export OPENMP_HOME=${SRC_HOME}/llvm-project/openmp
export COMGR_HOME=${SRC_HOME}/comgr

## Rocm Utilities
export ROCMINFO_HOME=${SRC_HOME}/rocminfo
export ROCPROFILER_HOME=${SRC_HOME}/rocprofiler
export AQLPROFILE_HOME=${SRC_HOME}/aqlprofile
export ROCMDBG_HOME=${SRC_HOME}/rocm-dbgapi
export ROCRDBGAGENT_HOME=${SRC_HOME}/rocr-dbg-agent
export ROCMGDB_HOME=${SRC_HOME}/rocm-gdb

## Flang components
export FLANG_HOME=${SRC_HOME}/flang
export FLANGRT_HOME=${SRC_HOME}/flang/runtime/flangrti
export PGMATH_HOME=${SRC_HOME}/flang/runtime/libpgmath

#########################################################################################################

#########################################################################################################
### BUILD HOME
#########################################################################################################
## Compiler Main Components
export LLVM_BUILD=${BUILD_HOME}/llvm
export COMPILERRT_BUILD=${BUILD_HOME}/compiler-rt
export DLIB_BUILD=${BUILD_HOME}/dlibs
export ROCR_BUILD=${BUILD_HOME}/rocr
export ROCT_BUILD=${BUILD_HOME}/roct
export VDI_BUILD=${BUILD_HOME}/vdi
export HIP_BUILD=${BUILD_HOME}/hip
export HIPAMD_BUILD=${BUILD_HOME}/hipamd
export OPENCL_BUILD=${BUILD_HOME}/opencl
export OPENMP_BUILD=${BUILD_HOME}/openmp
export COMGR_BUILD=${BUILD_HOME}/comgr

## Rocm Utilities
export ROCMINFO_BUILD=${BUILD_HOME}/rocminfo
export ROCPROFILER_BUILD=${BUILD_HOME}/rocprofiler
export AQLPROFILE_BUILD=${BUILD_HOME}/aqlprofile
export ROCMDBG_BUILD=${BUILD_HOME}/rocm-dbgapi
export ROCRDBGAGENT_BUILD=${BUILD_HOME}/rocr-dbg-agent
export ROCMGDB_BUILD=${BUILD_HOME}/rocm-gdb

## Flang components
export PGMATH_BUILD=${BUILD_HOME}/pgmath
export FLANG_BUILD=${BUILD_HOME}/flang
export FLANGRT_BUILD=${BUILD_HOME}/flangrti
#########################################################################################################

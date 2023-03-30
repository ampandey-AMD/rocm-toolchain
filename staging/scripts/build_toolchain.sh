
(./build_roct.sh)
(./build_llvm.sh)
#(./build_compiler_rt.sh asan-amdgpu)
(./build_devicelib.sh)
(./build_rocr.sh)

## Build Comgr runtime
(./build_comgr.sh)

(./build_rocminfo.sh)

## Build Flang Parser & Runtime
#(./build_flang_comp.sh)

## Build OpenCL runtime
(./build_opencl.sh)

## Build OpenMP runtime
(./build_openmp.sh)

## Build ROCclr runtime
#(./build_vdi.sh)

## Build HIP runtime
(./build_hipamd.sh)


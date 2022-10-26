__________________ORDER TO BUILD THE TOOLCHAIN_________________

./build_roct.sh

./build_rocr.sh

./build_llvm.sh

./build_devicelibs.sh

__________COMGR IS DEPENDENT ON LLVM AND DEVICE LIBS___________

./build_comgr.sh  

___________________LANGUAGE RUNTIMES BUILD_____________________

____OPENMP___

./build_openmp.sh

___HIP___

./build_vdi.sh

##Note:-./build_hipamd.sh BUILDS BOTH VDI AND HIP  

./build_hipamd.sh

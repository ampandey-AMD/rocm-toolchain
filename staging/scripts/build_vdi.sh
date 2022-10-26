echo -e "____________________________ Building VDI Runtime(ROCclr) ____________________________"
echo -e ""

SOURCE_DIR=${VDI_HOME}
OPENCL_DIR=${OPENCL_HOME}
HIP_DIR=${HIP_HOME}

if [ -d ${VDI_BUILD} ]; then
        rm -rf ${VDI_BUILD}
fi

mkdir -p ${VDI_BUILD}
cd ${VDI_BUILD}

CMAKE_OPTIONS=(
				-DCMAKE_C_COMPILER="clang" \
				-DCMAKE_CXX_COMPILER="clang++" \
        -DCMAKE_C_COMPILER="clang" \
				#-DCMAKE_C_FLAGS="-fsanitize=address -shared-libasan" \
				#-DCMAKE_CXX_FLAGS="-fsanitize=address -shared-libasan" \
				-DUSE_COMGR_LIBRARY=ON \
				-DROCM_DEP_ROCMCORE=ON \
				-DCMAKE_BUILD_TYPE="Debug" \
				-DCMAKE_PREFIX_PATH="${COMGR_BUILD};${LLVM_BUILD};${ROCM_PATH}/lib" \
				-DCMAKE_INCLUDE_PATH="${COMGR_BUILD}/include" \
)

(set -x; cmake -G "Unix Makefiles" ${CMAKE_OPTIONS[@]} ${SOURCE_DIR}; make -j${JOB_THREADS}; make -j${JOB_THREADS} install; set +x)

cd ${WORK_DIR}/scripts

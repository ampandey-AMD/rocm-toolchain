echo -e  "_____________________________ Building HSA Runtime(ROCR) _____________________________"
echo -e ""

SOURCE_DIR=${ROCR_HOME}/opensrc/hsa-runtime

if [ -d ${ROCR_BUILD} ]; then
        rm -rf ${ROCR_BUILD}
fi

mkdir -p ${ROCR_BUILD}
cd ${ROCR_BUILD}

cmake -G "Unix Makefiles" \
	-DCMAKE_C_COMPILER="gcc" \
	-DCMAKE_CXX_COMPILER="g++" \
	-DCMAKE_PREFIX_PATH=${ROCM_PATH} \
	-DCMAKE_INCLUDE_PATH=${ROCM_PATH}/include \
	-DCMAKE_LIBRARY_PATH=${ROCM_PATH}/lib \
	-DCMAKE_INSTALL_PREFIX=${INSTALL_HOME} \
	-DCMAKE_BUILD_TYPE="Debug" \
	$SOURCE_DIR

make -j${JOB_THREADS}
make -j${JOB_THREADS} install

#(set -x; cmake -G "Unix Makefiles" ${CMAKE_OPTIONS[@]} ${SOURCE_DIR}; make -j${JOB_THREADS}; make -j${JOB_THREADS} install; set +x)

cd ${WORK_DIR}/scripts

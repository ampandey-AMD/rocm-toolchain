echo -e  "_____________________________ Building HSA Runtime(ROCR) _____________________________"
echo -e ""

SOURCE_DIR=${AQLPROFILE_HOME}

if [ -d ${AQLPROFILE_BUILD} ]; then
        rm -rf ${AQLPROFILE_BUILD}
fi

mkdir -p ${AQLPROFILE_BUILD}
cd ${AQLPROFILE_BUILD}

CMAKE_OPTIONS=(
  -DCMAKE_C_COMPILER="gcc"
  -DCMAKE_CXX_COMPILER="g++"
  -DCMAKE_PREFIX_PATH=${ROCM_PATH}/hsa
  -DCMAKE_INCLUDE_PATH=${ROCM_PATH}/hsa/include
  -DCMAKE_LIBRARY_PATH=${ROCM_PATH}/hsa/lib
  -DCMAKE_INSTALL_PREFIX=${INSTALL_HOME}
  -DCMAKE_DEBUG_TRACE=1
  -DCMAKE_BUILD_TYPE="Release"
)

(set -x; cmake -G "Unix Makefiles" ${CMAKE_OPTIONS[@]} ${SOURCE_DIR}; make -j${JOB_THREADS}; make -j${JOB_THREADS} install; set +x)

cd ${WORK_DIR}/scripts

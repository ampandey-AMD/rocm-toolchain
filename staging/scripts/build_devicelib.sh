echo -e "___________________________ Building Device Libs ____________________________"
echo -e ""

SOURCE_DIR=${DLIB_HOME}

if [ -d ${DLIB_BUILD} ]; then
				rm -rf ${DLIB_BUILD}
fi

				mkdir -p ${DLIB_BUILD}
				cd ${DLIB_BUILD}

CMAKE_OPTIONS=(
				--trace-source=/home/ampandey/rocm-staging/rocm-device-libs/utils/prepare-builtins/CMakeLists.txt \
				-DCMAKE_C_COMPILER="gcc" \
				-DCMAKE_CXX_COMPILER="g++" \
				-DCMAKE_BUILD_TYPE="Debug" \
				-DCMAKE_PREFIX_PATH="$ROCM_PATH" \
				-DCMAKE_INSTALL_PREFIX=${INSTALL_HOME} \
)

(set -x; cmake -G "Unix Makefiles" ${CMAKE_OPTIONS[@]} ${SOURCE_DIR}; make -j${JOB_THREADS}; make -j${JOB_THREADS} install; set +x)

cd ${WORK_DIR}/scripts

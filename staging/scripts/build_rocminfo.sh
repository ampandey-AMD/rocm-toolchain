echo -e "___________________________ Building Rocminfo __________________________"

SOURCE_DIR=$ROCMINFO_HOME

if [ -d ${ROCMINFO_BUILD} ]; then
        rm -rf ${ROCMINFO_BUILD}
fi


mkdir -p ${ROCMINFO_BUILD}
cd ${ROCMINFO_BUILD}

CMAKE_OPTIONS=(
				-DCMAKE_C_COMPILER="gcc" \
				-DCMAKE_CXX_COMPILER="g++" \
				-DCMAKE_BUILD_TYPE="Release" \
				-DCMAKE_PREFIX_PATH="$ROCM_PATH" \
				-DCMAKE_INSTALL_PREFIX="$INSTALL_HOME" \
)

(set -x; cmake -G "Unix Makefiles" ${CMAKE_OPTIONS[@]} ${SOURCE_DIR}; make -j${JOB_THREADS}; make -j${JOB_THREADS} install; set +x)

cd $WORK_DIR/scripts

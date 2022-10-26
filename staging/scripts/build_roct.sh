echo -e "______________________ Building Rocm-Thunk-Interface(ROCT) ________________________"
echo -e ""

SOURCE_DIR=${ROCT_HOME}

if [ -d ${ROCT_BUILD} ]; then
        rm -rf ${ROCT_BUILD}
fi

        mkdir -p ${ROCT_BUILD}
        cd ${ROCT_BUILD}
cmake -G "Unix Makefiles" \
					-DCMAKE_C_COMPILER="gcc" \
					-DCMAKE_CXX_COMPILER="g++" \
					-DCMAKE_BUILD_TYPE="Debug" \
					-DCMAKE_PREFIX_PATH="/opt/rocm" \
					-DCMAKE_INSTALL_PREFIX="$INSTALL_HOME" \
					${SOURCE_DIR}

make -j${JOB_THREADS}
make -j${JOB_THREADS} install

#(set -x; cmake -G "Unix Makefiles" ${CMAKE_OPTIONS} ${SOURCE_DIR}; make -j${JOB_THREADS}; make -j${JOB_THREADS} install;set +x)

cd ${WORK_DIR}/scripts

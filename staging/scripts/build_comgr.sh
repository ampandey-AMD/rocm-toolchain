echo -e "________________________________ Building COMGr ____________________________"
echo -e ""

SOURCE_DIR=$COMGR_HOME/lib/comgr

if [ -d ${COMGR_BUILD} ]; then
        rm -rf ${COMGR_BUILD}
fi

mkdir -p ${COMGR_BUILD}
cd ${COMGR_BUILD}

cmake -G "Unix Makefiles" \
			-DCMAKE_C_COMPILER="clang" \
			-DCMAKE_CXX_COMPILER="clang++" \
			-DCMAKE_C_FLAGS="-I/opt/rocm/include" \
			-DCMAKE_CXX_FLAGS="-I/opt/rocm/include" \
			-DCMAKE_BUILD_TYPE="Debug" \
			-DCMAKE_PREFIX_PATH="$LLVM_BUILD;$DLIB_BUILD" \
			-DCMAKE_INSTALL_PREFIX="$INSTALL_HOME" \
			-DBUILD_SHARED_LIBS="ON" \
			-DBUILD_TESTING="OFF" \
			$SOURCE_DIR

make -j${JOB_THREADS}
make -j${JOB_THREADS} install

#(set -x; cmake -G "Unix Makefiles" ${CMAKE_OPTIONS[@]} ${SOURCE_DIR}; make -j${JOB_THREADS}; make -j${JOB_THREADS} install;set +x)

cd $WORK_DIR/scripts

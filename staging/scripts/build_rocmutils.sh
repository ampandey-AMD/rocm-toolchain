echo -e "________________________________________ Building ROCM Utilities ______________________________________________"
echo -e ""

mkdir -p ${ROCMDBG_BUILD}
mkdir -p ${ROCMGDB_BUILD}
mkdir -p ${ROCPROFILER_BUILD}

###### Build ROCM-DBGAPI #######
echo -e "_________ Building ROCM-DBG ___________"

cd ${ROCMDBG_BUILD}

$(set -x; cmake -DCMAKE_BUILD_TYPE="Release" -DCMAKE_INSTALL_PREFIX=${ROCM_PATH} ${ROCMDBG_HOME}; make -j${JOB_THREADS}; make -j${JOB_THREADS} install; set +x)

###### Build ROCR-DEBUG-AGENT ######
echo -e "________ Building ROCR-DEBUG-AGENT__________"

cd ${ROCRDBGAGENT_BUILD}

(set -x; cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER="gcc" -DCMAKE_CXX_COMPILER="g++" -DCMAKE_BUILD_TYPE="Release" -DCMAKE_PREFIX_PATH="$Debug_Agent_PREFIX_PATH" -DCMAKE_INSTALL_PREFIX="$INSTALL_HOME" $SOURCE_DIR; make -j${JOB_THREADS}; make -j${JOB_THREADS} install; set +x)

###### Build ROC-PROFILER #######
echo -e "_________________ Building ROC-PROFILER __________________"

cd ${ROCPROFILER_BUILD}

(set -x; cmake -DCMAKE_BUILD_TYPE="Release" -DCMAKE_INSTALL_PREFIX=${ROCM_PATH} ${ROCPROFILER_HOME}; make -j$(nproc); make -j$(nproc) install)

###### Build ROCM-GDB ########
echo -e "________ Building ROCM-GDB ___________"

cd ${ROCMGDB_BUILD}

$ROCMGDB_HOME/configure --program-prefix=roc \
				--enable-64-bit-bfd --enable-targets="x86_64-linux-gnu,amdgcn-amd-amdhsa" \
				--disable-ld --disable-gas --disable-gdbserver --disable-sim --enable-tui \
				--disable-gdbtk --disable-shared --with-expat --with-system-zlib \
				--without-guile --with-babeltrace --with-lzma --with-python=python3 --with-rocm-dbgapi=${ROCM_PATH} --prefix=${ROCM_PATH}

make -j${JOB_THREADS}
sudo make -j${JOB_THREADS} install

cd $WORK_DIR/scripts

###################################################################################################################################
############################ Note: Please run the export_common_vars.sh first before running this one #############################
###################################################################################################################################
declare -A clone_list
declare -A dir_list

USERNAME=$USER

clone_list['llvm-project']="ssh://$USERNAME@gerrit-git.amd.com:29418/lightning/ec/llvm-project"
clone_list['device-libs']="ssh://$USERNAME@gerrit-git.amd.com:29418/lightning/ec/device-libs"
clone_list['comgr']="ssh://$USERNAME@gerrit-git.amd.com:29418/lightning/ec/support"
clone_list['opencl']="ssh://$USERNAME@gerrit-git.amd.com:29418/compute/ec/opencl"
clone_list['hip']="ssh://$USERNAME@gerrit-git.amd.com:29418/compute/ec/hip"
clone_list['hipamd']="ssh://$USERNAME@git.amd.com:29418/compute/ec/hipamd"
clone_list['vdi']="ssh://$USERNAME@gerrit-git.amd.com:29418/compute/ec/vdi"
clone_list['rocr']="ssh://$USERNAME@gerrit-git.amd.com:29418/hsa/ec/hsa-runtime"
clone_list['roct']="ssh://$USERNAME@gerrit-git.amd.com:29418/compute/ec/libhsakmt"
clone_list['rocminfo']="ssh://$USERNAME@gerrit-git.amd.com:29418/compute/ec/rocminfo"
clone_list['rocm-gdb']="ssh://$USERNAME@gerrit-git.amd.com:29418/compute/ec/rocm-gdb"
clone_list['rocm-dbgapi']="ssh://$USERNAME@gerrit-git.amd.com:29418/compute/ec/rocm-dbgapi"
clone_list['rocr-debug-agent']="ssh://ampandey@gerrit-git.amd.com:29418/DevTools/ec/rocr_debug_agent"
clone_list['roctracer']="ssh://$USERNAME@gerrit-git.amd.com:29418/compute/ec/roctracer"
clone_list['rocprofiler']="ssh://$USERNAME@gerrit-git.amd.com:29418/compute/ec/rocprofiler"
clone_list['aqlprofile']="ssh://$USERNAME@gerrit-git.amd.com:29418/hsa/ec/aqlprofile"
### Flang repo
clone_list['flang']="https://github.com/ROCm-Developer-Tools/flang"

### Math Libraries
clone_list['rocblas']="ssh://$USERNAME@gerrit-git.amd.com:29418/compute/ec/rocblas"

dir_list['llvm-project']="amd-stg-open"
dir_list['device-libs']="amd-stg-open"
dir_list['comgr']="amd-stg-open"
dir_list['opencl']="amd-staging"
dir_list['hip']="amd-staging"
dir_list['hipamd']="main"
dir_list['vdi']="amd-staging"
dir_list['rocr']="amd-staging"
dir_list['roct']="amd-staging"
dir_list['rocminfo']="amd-staging"
dir_list['rocm-gdb']="amd-staging"
dir_list['rocm-dbgapi']="amd-staging"
dir_list['rocr-debug-agent']="amd-master"
dir_list['roctracer']="amd-staging"
dir_list['rocprofiler']="amd-staging"
dir_list['aqlprofile']="amd-staging"
dir_list['flang']="master"
dir_list['rocblas']="amd-master"

function check_Clone_OR_Pull(){
DIR_NAME="$1"
if [[ -d "$DIR_NAME" ]];then
				echo -e " Executing \"git pull\" in $DIR_NAME at branch \"${dir_list["$DIR_NAME"]}\"..."
				(set -x; cd ${DIR_NAME}; git pull; cd ..)
				echo -e ""
else
				echo -e " \"$DIR_NAME\" does not exists!"
				(set -x; git clone -b ${dir_list["$DIR_NAME"]} ${clone_list["$DIR_NAME"]} ${DIR_NAME})
				echo -e ""
fi
}

function run_Clone_OR_Pull(){
### LLVM
check_Clone_OR_Pull 'llvm-project'

### DEVICE LIBS
check_Clone_OR_Pull 'device-libs'

### COMPILER SUPPORT(COMGR)
check_Clone_OR_Pull 'comgr'

### OPENCL
check_Clone_OR_Pull 'opencl'

### HIP
check_Clone_OR_Pull 'hip'

### HIP-AMD
check_Clone_OR_Pull 'hipamd'

### VDI(ROCClr)
check_Clone_OR_Pull 'vdi'

### ROCR(HSA-RUNTIME)
check_Clone_OR_Pull 'rocr'

### ROCT
check_Clone_OR_Pull 'roct'

### ROCM_INFO
check_Clone_OR_Pull 'rocminfo'

### ROCM-GDB
check_Clone_OR_Pull 'rocm-gdb'

### ROCM-DBGAPI
check_Clone_OR_Pull 'rocm-dbgapi'

### ROCR-DEBUG-AGENT
check_Clone_OR_Pull 'rocr-debug-agent'

### ROCM-PROFILER
check_Clone_OR_Pull 'rocprofiler'

### ROCM-TRACER
check_Clone_OR_Pull 'roctracer'

### AQL-PROFILE
check_Clone_OR_Pull 'aqlprofile'

### FLANG
check_Clone_OR_Pull 'flang'

### ROCBLAS
check_Clone_OR_Pull 'rocblas'
}

echo -e "Cloning all source codes into \"src-home\" directory!"

if [ -d "$SRC_HOME" ];then
	echo -e "${SRC_HOME} directory is present!"
else
	echo -e "Creating directory \"src-home\"!..."
	mkdir -p ${SRC_HOME}
fi

cd ${SRC_HOME}
run_Clone_OR_Pull

cd ${WORK_DIR}/scripts

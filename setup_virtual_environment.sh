#/bin/bash

source_repo=$1
branch=$2
dist_repo=$3
application=$4
build_id=`date +%s`
build_dir=/tmp/build_${application}_${build_id}
project_source=${build_dir}/source
venv_dir=${build_dir}/env

if [[ "$branch" != "" ]]; then
	branch_clause="-b $branch"
fi

mkdir -p $project_source
mkdir -p $venv_dir

# Download Source

git clone $branch_clause $source_repo $project_source 

#Create a python virtual environment
virtualenv $venv_dir
source $venv_dir/bin/activate

# install dependancy modules
my_dir=$(pwd)
cd $project_source
python3 "$project_source/setup.py" develop
cd $my_dir

deactivate


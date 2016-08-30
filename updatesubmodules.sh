#!/bin/bash

function re_source {
    echo Please run from the command line with:
    echo "source updatesubmodules.sh"
    sleep 5
    exit
}

function normalUpdate()
{
    # initialize all the submodules
    git submodule init
    git submodule sync
    # clone the commit IDs configured in the parallella superproject
    git submodule update
    # clone all the submodules
    git submodule foreach git submodule init
    git submodule foreach git submodule sync
    git submodule foreach git submodule update
}

if [ `basename "$0"` != "bash" ]; then
    re_source
    exit
fi

# The following part of the script seems to run better if
# you run from the command line with source updatesubmodules.sh

# get the latest
git fetch --all
# dont think this needs to be recursive, just ensure that the
# top level is fetched.
# git submodule foreach git fetch --all
# git submodule foreach git submodule foreach git fetch --all

changes=0
while read status filename; do
    changes=1

    echo error: Changes detected in $filename
    echo suggest update to latest by hand
    echo ------------
    echo abandoned
    echo ------------
done < <(git status --porcelain)
if [ $changes == 0 ]; then
    echo No changes

    branch="elink-redesign"
    
    # ensure we are on elink-redesign
    echo ------------
    echo "INFO:  Update branch $branch"
    echo ------------
    git checkout $branch

    # ensure that we are tracking the remote branch
    git branch --set-upstream-to=origin/$branch $branch

    # pull in the latest changes
    git pull
    
    normalUpdate
    echo Done Update
else
    echo ------------
    echo Suggest you update specific content individually.
    echo Consider checking in your changes on a personal branch and then merging
    echo latest branch.  An alternative is to clean the repositories and re-run
    echo source updatesubmodules.sh to update.
    echo
    echo For example reset changes for all changed files like this:
    echo cd parallella-yoctobuild/meta-example
    echo git checkout -- recipes-bsp/bitstream/parallella-hdmi-bitstream.bbappend
    echo
    echo The above command will remove any modifications that you have made
    echo to add your own bitstream spec to the build.
    echo
    echo You may also need to clean the parallella-fpga project before you attempt
    echo to update.  To help with cleaning the parallella-fpga project look at
    echo parallella-fpga/revertlocalchanges.sh and consider running that script
    echo to clean the fpga folders.
    echo
    echo Once cleaned rerun source updatesubmodules.sh to update
    echo
    echo To make updates easier in the future consider putting your work in one
    echo of the .gitignore folders for example mywork, project, projects, test
    echo see each submodules .gitignore for details.
    echo ------------
fi




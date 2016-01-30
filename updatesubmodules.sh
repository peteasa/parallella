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
    # clone the commit IDs configured in the parallella superproject
    git submodule update
    # clone all the submodules
    git submodule foreach git submodule init
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

let changes=0
while read status filename; do
    let changes=1

    echo error: Changes detected in $filename
    echo suggest update to latest by hand
    echo ------------
    echo abandoned
    echo ------------
done < <(git status --porcelain)
if [ $changes == 0 ]; then
    echo No changes

    let branch=parallella-oh
    
    # ensure we are on parallella-oh
    git checkout $branch

    # ensure that we are tracking the remote branch
    git branch --set-upstream-to=origin/$branch $branch

    # pull in the latest changes
    git pull
    
    normalUpdate
    echo Done Update
else
    echo ------------
    echo Suggest you update specific content individually
    echo consider checking in your changes and then merging latest branch
    echo alternative is to clean the repositories and re-run this command
    echo
    echo for example reset changes for all changed files like this:
    echo cd parallella-yoctobuild/meta-example
    echo git checkout -- recipes-bsp/bitstream/parallella-hdmi-bitstream.bbappend
    echo
    echo will remove any modifications that you have made to add your own bitstream spec to the build
    echo
    echo You may also need to clean the parallella-fpga project before you attempt to update.  As this will remove a lot of generated files please consider running 
    echo To help with this look at parallella-fpga/revertlocalchanges.sh and
    echo consider running that script to clean out the fpga folders
    echo
    echo then rerun source updatesubmodules.sh to update
    echo
    echo To make updates easier in the future consider putting your work
    echo in one of the .gitignore folders for example mywork, project, projects, test
    echo see each submodules .gitignore for details.
    echo ------------
fi




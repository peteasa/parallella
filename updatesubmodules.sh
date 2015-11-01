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

# ensure we are on elink-redesign
git checkout elink-redesign

# ensure that we are tracking the remote elink-redesign branch
git branch --set-upstream-to=origin/elink-redesign elink-redesign

# pull in the latest changes
git pull

if [ `basename "$0"` != "bash" ]; then
    re_source
    exit
fi

# The following part of the script seems to run better if
# you run from the command line with source updatesubmodules.sh

# get the latest
git fetch --all

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
    echo then rerun source $0 to update
    echo ------------
fi


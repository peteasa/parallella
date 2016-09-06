#!/bin/bash

function re_source {
    echo ERROR Please run from the command line with:
    echo "source ./updatesubmodules.sh"
    sleep 2
    [[ $PS1 ]] && return || exit;
}

if [[ $_ = $0 ]]
then
    re_source
fi

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

function abandon()
{
    echo INFO: Suggest update to latest by hand
    echo ------------
    echo updatesubmodules abandoned
}

function message()
{
    echo ------------
    echo Changes in the source tree have been detected. Either discard the changes
    echo For example:
    echo "  cd parallella-yoctobuild/meta-example"
    echo "  git checkout -- recipes-bsp/bitstream/parallella-hdmi-bitstream.bbappend"
    echo
    echo Or in parallella-fpga consider running the clean script
    echo "  cd parallella-fpga"
    echo "  source revertlocalchanges.sh"
    echo
    echo Or check in the changes you want to keep.
    echo
    echo To the make updates easier in the future consider putting your work in one
    echo of the .gitignore folders for example mywork, project, projects, test
    echo see each submodules .gitignore for details.
    echo ------------
}

changes=0

function checkchanges()
{
    pwd=`pwd`
    cd $1
    while read status filename; do
        changes=1

        echo ------------
        echo Warning: Changes detected in $1/$filename
    done < <(git status --porcelain)

    cd $pwd
}

# The following part of the script seems to run better if
# you run from the command line with source updatesubmodules.sh

## This script will change the current branch to:
branch="elink-redesign"

echo ------------
echo "INFO:  Checkout $branch"
echo ------------
git checkout $branch

if [[ $? == 0 ]]; then

    # ensure that we are tracking the remote branch
    git branch --set-upstream-to=origin/$branch $branch

    # get the latest
    git fetch --all

    echo ------------
    echo "INFO:  Merge origin/$branch into $branch to update to latest"
    echo ------------
    git merge origin/$branch --no-edit

    normalUpdate

else
    abandon
fi

echo "INFO: Looking for changes in all submodules"
checkchanges .
checkchanges parallella-yoctobuild
checkchanges parallella-fpga

if [[ $changes == 1 ]]; then
    message
fi

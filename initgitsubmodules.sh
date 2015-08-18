#!/bin/sh

# initialize all the submodules
git submodule init
# clone the commit IDs configured in the parallella superproject
git submodule update
# clone all the submodules
git submodule foreach git submodule init
git submodule foreach git submodule update


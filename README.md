# parallella playground - elink-redesign branch

The aim is to create a one stop environment for parallella development

### References:

https://github.com/peteasa/parallella-yoctobuild - A Simple build environment for [Parallella](http://www.parallella.org/) using [Yocto](http://www.yoctoproject.org/)
https://github.com/parallella/parallella-hw.git - PARALLELLA: Supercomputing for Everyone - open source board and FPGA designs associated with the Parallella project.
https://github.com/analogdevicesinc/hdl - Analog Devices HDL libraries and projects

### Provides:

A working environment for a developer to take an idea from concept to working release on the Parallella platform.  The Xilinx tools are required to build the parallella fpga and a few build essentials are required for the Yocto Linux build, but after that the job of ensuring that the matching Linux, Analog Devices hdl, Open Hardware is provided by choosing the appropriate branch in this repository and checking out the matching submodules.


## Instructions

### Installing required packages

To use `yocto` you first need to install some packages. See latest [Yocto Project Quick Start](http://www.yoctoproject.org/docs/latest/yocto-project-qs/yocto-project-qs.html). This assumes you are working on a Ubuntu machine:

```bash
$ sudo apt-get install gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat libsdl1.2-dev xterm
```

### Cloning this repository

Clone this repository onto your Linux build machine:
```bash
$ git clone git@github.com:peteasa/parallella
$ cd parallella
```

Checkout the branch that provides the versions that you want to use then to prepare the environment and download the necessary git submodules, you need to run the `initgitsubmodules.sh` script. This only needs to be done once:

```bash
$ source initgitsubmodules.sh
```

The result will be new folders `examples`, `parallella-fpga/parallella-hw`, `parallella-fpga/7020_hdmi`, `parallella-fpga/AdiHDLLib`, `parallella-yoctobuild`, `parallella-yoctobuild/poky`, `parallella-yoctobuild/meta-xilinx`, `parallella-yoctobuild/meta-parallella` and `parallella-yoctobuild/meta-epiphany` created from specific commits on github.`

### Setting up your shell environment

For full instructions to setup the parallella-yoctobuild environment see https://github.com/peteasa/parallella-yoctobuild
For full instructions to setup and use xilinx tools to build an fpga using the paralllella-hw submodule visit http://parallellagram.org/

### Links to other information

Troubleshooting notes - [Troubleshooting notes](https://github.com/peteasa/parallella-yoctobuild/wiki/Troubleshooting-notes)

Instructions for contributors - [Instructions for contributors](https://github.com/peteasa/parallella-yoctobuild/wiki/Instructions-for-contributors)


---------------------------------------

  * TODO instructions for building the examples
  * TODO oh yes need to add / create the examples!

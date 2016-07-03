#!/bin/bash

PYTHON=$1

https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
chmod +x miniconda.sh
./miniconda.sh -b

export PATH=$HOME/miniconda3/bin:$PATH
echo "export PATH=\$HOME/miniconda3/bin:\$PATH" >> ~/.bashrc

export CONDA_INSTALL="conda install --yes -q"
echo "export CONDA_INSTALL=\"conda install --yes -q\"" >> ~/.bashrc

conda create -n travisci --yes python=$PYTHON
source activate travisci

$CONDA_INSTALL -c numba llvmdev=3.7.1
$CONDA_INSTALL numba numpy scipy pip sphinx sphinx_rtd_theme pygments pytest

if [ $PYTHON \< "3.4" ];
then
    $CONDA_INSTALL enum34;
fi

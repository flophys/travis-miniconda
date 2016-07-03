#!/bin/bash

if [[ "$TRAVIS_PYTHON_VERSION" == "2.7" ]]; then
    wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -O miniconda.sh;
else
    wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh;
fi
bash miniconda.sh -b -p $HOME/miniconda

export PATH="$HOME/miniconda/bin:$PATH"
echo "export PATH=\"\$HOME/miniconda/bin:\$PATH\"" >> ~/.bashrc
hash -r

conda config --set always_yes yes --set changeps1 no
conda update -q conda
conda info -a
conda create -q -n travisci python=$TRAVIS_PYTHON_VERSION numba numpy scipy pip sphinx sphinx_rtd_theme pygments pytest
source activate travisci
conda install --yes -q -c numba llvmdev=3.7.1

if [ $TRAVIS_PYTHON_VERSION \< "3.4" ];
then
    conda install --yes -q enum34;
fi

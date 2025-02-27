Advanced Container Build with Pytorch
=====================================

In this tutorial, we will build off content from TACCs container tutorial by detailing how to build the GPU enabled container for a BERT classifier python script.  This tutorial is specifically an extension of `TACCs GPU aware containers tutorial <https://containers-at-tacc.readthedocs.io/en/latest/singularity/03.mpi_and_gpus.html#building-a-gpu-aware-container>`_.


Outline
~~~~~~~
    1. Figure out which CUDA, pytorch, python version, and which additional python packages you need
    2. Get a docker image with the CUDA version you want
    3. Build a docker container on top of this image with the python, pytorch, and other packages you need
    4. Upload container to dockerhub and then download it onto frontera and convert it to an apptainer container

BERT classifier code requirements
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    - We want to run the code contained in the bert-classifier.py script.  This code requires:
    - CUDA 11.0
    - Python 10
    - pytorch 1.7.1

Additional required python packages listed in requirements.txt

::

    seaborn == 0.11.2
    scikit-learn == 0.24.2
    scipy == 1.7.1
    tokenizers == 0.20.3
    torchtext >= 0.8.1
    transformers == 4.16.2

=======================

It also requires the following data files:

- `train.csv <https://github.com/eriksf/bert-classifier/raw/main/train.csv>`_
- `test.csv <https://github.com/eriksf/bert-classifier/raw/main/test.csv>`_ 
- `valid.csv <https://raw.githubusercontent.com/eriksf/bert-classifier/main/valid.csv>`_

Selecting a CUDA docker image to build from
Once you know which version of CUDA you need, you can find a docker image from `nvidia’s dockerhub page <https://hub.docker.com/r/nvidia/cuda>`_ that has the correct CUDA version.  Their CUDA images come in three flavors, base, runtime, and development:

The image tag syntax is:

::

    [CUDA version #]-[optional cudnn]-[base/runtime/devel]-[os version]

As an example, the CUDA 11.0.3 runtime image with cuDNN has the tag:

::

    11.0.3-cudnn8-runtime


Pytorch install command
-----------------------
The pytorch website provides a useful app here that will tell you the correct pip install command for the latest or the nightly build of pytorch for various platforms and OS’s.  The “Compute Platform” row at the above link will tell you which CUDA versions are compatible with the stable and nightly pytorch versions.  Explanations of how to install older versions of pytorch can be found on their website here. For the latest stable pytorch release their website recommends you to use python 3.9-3.12.

The pytorch version we want can be found in the “older versions” section of the website.  Scrolling down to v1.7.1 look for the “wheel” section that provides the pip install command for Linux/Windows for CUDA 11.  The command is:

::

    pip install torch==1.7.1+cu110 torchvision==0.8.2+cu110 torchaudio==0.7.2 -f https://download.pytorch.org/whl/torch_stable.html

Writing a Dockerfile
--------------------
Now we can put everything together and build our container. The general process is that we use the FROM command to start with the nvidia CUDA container, then a series of RUN commands to install python and then perform pip installs of the desired python packages. Finally, we will copy in our script and data files into the container.


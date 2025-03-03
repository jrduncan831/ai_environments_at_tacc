Advanced Container Build with Pytorch
=====================================

In this tutorial, we will build off content from TACCs container tutorial by detailing how to build the **GPU enabled container** for a BERT classifier python script.  This tutorial is an extension of `TACCs GPU aware containers tutorial <https://containers-at-tacc.readthedocs.io/en/latest/singularity/03.mpi_and_gpus.html#building-a-gpu-aware-container>`_.

We will be covering:

    1. Determining which CUDA, pytorch, python version, and which additional python packages you need.
    2. Retrieving a docker image with the CUDA version you want.
    3. Building a docker container on top of this image with python, pytorch, and other packages you need.
    4. Uploading your container to dockerhub, downloading it onto Frontera, and converting it to an Apptainer for use on TACC systems.

BERT classifier code requirements
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


    - We want to run the code contained in the bert-classifier.py script.  This code requires:
    - CUDA 11.0
    - Python 10
    - pytorch 1.7.1

Additional required python packages listed in requirements.txt are:

::

    seaborn == 0.11.2
    scikit-learn == 0.24.2
    scipy == 1.7.1
    tokenizers == 0.20.3
    torchtext >= 0.8.1
    transformers == 4.16.2

=======================

Running a BERT model will also require the following data files:

- `train.csv <https://github.com/eriksf/bert-classifier/raw/main/train.csv>`_
- `test.csv <https://github.com/eriksf/bert-classifier/raw/main/test.csv>`_ 
- `valid.csv <https://raw.githubusercontent.com/eriksf/bert-classifier/main/valid.csv>`_

These are the **training**, **testing**, and **validation** data respectively.

Selecting a CUDA docker image to build from
-------------------------------------------
Once you know which version of CUDA you need, you can find a docker image from `nvidia’s dockerhub page <https://hub.docker.com/r/nvidia/cuda>`_ that has the correct CUDA version.  Their CUDA images come in three varieties: base, runtime, and development.

#. Step 1. base : includes the CUDA runtime (cudart)
#. Step 2. runtime : Builds on the base and includes the CUDA math libraries and nccl. A runtime image that also includes cuDNN is available.
#. Step 3. devel : Builds on the runtime and includes headers, development tools for building CUDA images. These images are particularly useful for multi-stage builds

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

::

    FROM nvidia/cuda:11.0.3-cudnn8-runtime-ubuntu20.04

    # Install python and pip
    RUN apt-get update 
    RUN apt-get install -y python3.8 
    RUN apt-get install -y python3-pip
    RUN pip install --upgrade pip

    # Install pytorch
    RUN pip install torch==1.7.1+cu110 \
		torchvision==0.8.2+cu110 \
		torchaudio==0.7.2 \
		-f https://download.pytorch.org/whl/torch_stable.html

    # Copy in requirements file and install required python pip packages
    COPY requirements.txt .
    RUN pip install -r requirements.txt

    # Move to /code dir and add it to path
    WORKDIR /code
    ENV PATH=/code:$PATH

    # Copy our code and training data, make it read/executable
    COPY test.csv train.csv valid.csv /code/ 
    COPY bert_classifier.py /code
    RUN chmod +rx /code/bert_classifier.py
    RUN chmod +r /code/*.csv

Building a docker image from the Dockerfile
When building the container, we have to build it for the specific computer architecture we plan to run the container on. 
In the case of Frontera, that’s linux/amd64, for Vista it’s linux/arm64.  
A tutorial of how to automatically make builds for all possible architectures simultaneously is available `here <https://containers-at-tacc.readthedocs.io/en/latest/advanced/02.multiarchitecture.html>`_.  
Also note, Docker Desktop on Mac/Windows can build for architectures different than the one they are running on by default, but Linux requires some additional software libraries (outlined in the linked tutorial)

After you’ve saved your dockerfile, navigate to its location.  Ensure the bert_classifier.py, train.csv, test.csv, valid.csv, and requirements.txt files are all in the same directory as the dockerfile. Now run the following command to build the container:

::

    docker build --platform [architecture] -t [username]/[container name]:[tag] .

Example:

::

    docker build --platform linux/amd64 -t gjaffe/bert-classifier:0.0.1 .

**Optional: Test container locally**

If you want to test out the container locally on a system with gpus you can run

::

    docker run --gpus all --ipc=host -it --rm [username]/[container name]:[tag]

Example:

::

    docker run --gpus all --ipc=host -it --rm gjaffe/bert-classifier:0.0.1

Upload container to dockerhub
-----------------------------

Once you’re satisfied with your container, you can upload the docker image to docker hub

::

    docker login
    docker push [username]/[container name]:[tag]

Example:

::

    docker push gjaffe/bert-classifier:0.0.1

Installing container on TACC systems
------------------------------------

Now that you have a container on dockerhub, using it on TACC systems is straightforward. You don’t need an rtx node to run apptainer, but since most of our ML software requires GPUs, I find it easier to use an rtx node so I can test the container immediately

Grab a single rtx node on Frontera:

::

    idev -N 1 -p rtx-dev -m 120

Load apptainer module

::

    module load tacc-apptainer

Pull container from dockerhub

::

    apptainer pull docker://[username]/[container name]:[tag]

Example:

::
    
    apptainer pull docker://gjaffe/bert-classifier:0.0.1

This will create an apptainer container file in your current working directory with a “.sif” extension. You can rename the container to whatever you’d like. To run the container with an interactive shell and with nvidia gpu drivers activated (--nv flag) use this command:

::
    
    apptainer shell --nv [container name]

Example 

::
    
    apptainer shell --nv bert-classifier_0.0.1.sif 

Once you are inside the the container with an interactive shell, you can run the classifier code with the command:

::

    python3 /code/bert_classifier.py

You have now succesfully built a GPU aware Pytorch container for a specific BERT application on Frontera.  In the next tutorial, we will talk about how you can set up this container as a kernel of a jupyter notebooks on TACC's system. 

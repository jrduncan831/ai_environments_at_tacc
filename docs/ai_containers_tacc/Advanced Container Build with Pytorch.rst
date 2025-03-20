Advanced Container Build with Pytorch
=====================================

In this tutorial, we will build off content from TACCs container tutorial by detailing how to build the **GPU-enabled container** for a BERT classifier python script.  This tutorial is an extension of `TACCs GPU aware containers tutorial <https://containers-at-tacc.readthedocs.io/en/latest/singularity/03.mpi_and_gpus.html#building-a-gpu-aware-container>`_.
Prerequisite knowledge about the Docker platform and containerization is necessary to follow along with this tutorial, which can be found on the `TACC Containers Tutorial <https://containers-at-tacc.readthedocs.io/en/latest/index.html>`_ website.

The process for containerizing your code is as follows:

* **Determine the necessary dependencies**, including the required versions of CUDA, PyTorch, Python, and additional Python packages. 
* **Select the appropriate NVIDIA CUDA base image**
* **Create a Dockerfile** which will include the commands to install all our dependencies
* **Build the container**
* **Upload the container image to Docker Hub**
* **Pull the container to TACC systems like Frontera, and run it**,

By the end of this tutorial, we will have a fully customized, GPU-accelerated container for running BERT classification tasks on TACC's high-performance computing resources.


BERT classifier code requirements
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

We want to run the code contained in the `bert-classifier.py <https://raw.githubusercontent.com/eriksf/bert-classifier/main/bert_classifier.py>`_ script, which requires:
    - CUDA 11.0
    - Python 10
    - pytorch 1.7.1

Additional required python packages listed in requirements.txt are:

::

    seaborn == 0.11.2
    scikit-learn == 0.24.2
    scipy == 1.7.1
    tokenizers == 0.20.3
    torchtext == 0.8.1
    transformers == 4.16.2

=======================

Running a BERT model will also require the following data files:

- `train.csv <https://github.com/eriksf/bert-classifier/blob/main/train.csv>`_
- `test.csv <https://github.com/eriksf/bert-classifier/blob/main/test.csv>`_ 
- `valid.csv <https://github.com/eriksf/bert-classifier/blob/main/valid.csv>`_

These are the **training**, **testing**, and **validation** data respectively.

Below, we will walk you through some of the components you will need on your Dockerfile.

Selecting a CUDA docker image to build from
-------------------------------------------
Once you know which version of CUDA you need (11.0 in this case), you can find a docker image from `nvidia’s dockerhub page <https://hub.docker.com/r/nvidia/cuda>`_ that has the correct CUDA version.  Their CUDA images come in three varieties: base, runtime, and development.

* **Base**
    * The **base** image is the most minimal CUDA image, only containing the CUDA runtime (cudrt) and necessary dependencies.
    * Best suited for running precompiled CUDA applications or minimal environments.
* **Runtime** 
    * The **runtime** image is one step above the base image, and includes the CUDA runtime and necessary libraries (e.g., cuBLAS, cuDNN if specified).
    * Ideal for deploying applications that need CUDA support but do not require compilation.
* **Development**
    * The **development** image is built on top of the runtime image and includes the CUDA compiler (nvcc), development headers, and other necessary tools for building and compiling multi-stage CUDA applications.
    * Best for development environments where CUDA code needs to be compiled inside the container.

**Declare the CUDA base image**
When you create a Dockerfile, the first line specifies the CUDA base image:

:: 

    FROM nvidia/cuda:11.0.3-cudnn8-runtime-ubuntu20.04

The image tag syntax is:

::

    [CUDA version #]-[optional cudnn]-[base/runtime/devel]-[os version]

As an example, the CUDA 11.0.3 runtime image with cuDNN has the tag:

::

    11.0.3-cudnn8-runtime

This tells Docker to pull the nvidia/cuda:11.0.3-cudnn8-runtime-ubuntu20.04 image from Docker Hub when the container is built.

Command for Installing Pytorch
------------------------------
We also need Pytorch to be present in our Dockerfile to run BERT.

The PyTorch website provides a `tool <https://pytorch.org/get-started/locally/>`_ called **Compute Platform** to generate the correct installation command for different environments. Since we need PyTorch 1.7.1 with CUDA 11.0, we will use the following command:

The pytorch version we want can be found in the “older versions” section of the website.  Scrolling down to v1.7.1 look for the “wheel” section that provides the pip install command for Linux/Windows for CUDA 11.  The command is:

::

    pip install torch==1.7.1+cu110 torchvision==0.8.2+cu110 torchaudio==0.7.2 -f https://download.pytorch.org/whl/torch_stable.html


Writing a Dockerfile
--------------------
A Dockerfile **automates** the container creation process. Now that we have our components, we can assemble them and use them to build our container. 
The general pipeline for building a Dockerfile is to use the FROM command to start with the Nvidia CUDA container, then place a series of RUN commands below it to install Python and perform pip installs of the desired Python packages.
Then, we can copy our script and data (test.csv, train.csv, and valid,csv) into our file.

Below is an example Dockerfile that:

- Uses an NVIDIA CUDA runtime base image.
- Installs Python and Pip.
- Installs PyTorch and required dependencies.
- Copies the BERT classifier script and dataset into the container.

Example Dockerfile
------------------
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
-------------------------------------------

When building the container, we have to build it for the specific computer architecture we plan to run the container on. 
In the case of Frontera, that’s linux/amd64, for Vista it’s linux/arm64. Specific architectures for TACC systems can be found `here. <https://tacc.utexas.edu/systems/all/>`_

A tutorial of how to automatically make builds for all possible architectures simultaneously is available `here <https://containers-at-tacc.readthedocs.io/en/latest/advanced/02.multiarchitecture.html>`_.  

.. note::
    Docker Desktop on Mac/Windows can build for architectures different than the one they are running on by default, but Linux requires some additional software libraries (outlined in the linked tutorial)

After you’ve saved your dockerfile, navigate to its location in your **terminal**.  Ensure the bert_classifier.py, train.csv, test.csv, valid.csv, and requirements.txt files are all in the same directory as the dockerfile. Now run the following command to build the container:

::

    docker build --platform [architecture] -t [username]/[container name]:[tag] .

Example:

::

    docker build --platform linux/amd64 -t gjaffe/bert-classifier:0.0.1 .

**Optional: Test container locally**

If you want to test out the container locally on a system with gpus, you can run:

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

Now that you have a container on dockerhub, using it on TACC systems is straightforward. You don’t need an rtx node to run apptainer, but since most of our ML software requires GPUs, it is typically easier to use an rtx node so we can test our container immediately:

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

Congratulations! You have successfully **built and deployed a GPU-accelerated PyTorch container** for a **BERT classification model on TACC**. In the next tutorial, we will explore how to integrate this container as a Jupyter Notebook kernel on TACC’s system.

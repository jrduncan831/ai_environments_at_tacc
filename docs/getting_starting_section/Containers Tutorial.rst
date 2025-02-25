Containers Tutorial
===================

Docker is a platform for developing, shipping, and running applications inside containers. Containers are lightweight, portable, and ensure that applications run consistently across different environments. TACC already has an excellent resources for `building containers at TACC<https://containers-at-tacc.readthedocs.io/en/latest/>`_. Our goal with this introduction is to do a quick review of this tutorial with emphasis on AI/ML applications.  If you are new to containers, we highly suggest you review the containers tutorial first.  In this tutorial, we will review key concepts about containers at TACC as well as review how to utilize base gpu enabled containers at TACC.

What is a Docker Image?
-----------------------
A Docker image is a pre-configured package that contains everything needed to run an application, including the code, runtime, libraries, and dependencies. Once an image is instantiated, it becomes a container, which is an isolated runtime environment.

Apptainer vs Container
----------------------
Apptainer (formerly Singularity) is a containerization platform designed specifically for high-performance computing (HPC) environments, offering a solution optimized for scientific research and large-scale data processing. Unlike general containers like Docker, which require root privileges and are commonly used for development and cloud-based applications, Apptainer is built to run efficiently on shared systems, such as TACC’s supercomputers and clusters. It provides portability, reproducibility, and seamless integration with HPC job schedulers making it ideal for researchers who need to run complex applications in secure, isolated environments without compromising performance or requiring administrative access.  

In this tutorial, we follow the workflow highlighted in [TACC's container tutorial](https://containers-at-tacc.readthedocs.io/en/latest/singularity/01.singularity_basics.html) where we will a use docker to develop containers locally, push them to docker hub and then use apptainer to run the container on our HPC systems.

Setting GPU enabled PyTorch Container at TACC
---------------------------------------------
Below we will walk you through the steps for setting up a GPU enabled Pytorch container at TACC.  

**Step 1: Login to Frontera**  

We will use the Frontera supercomputer in this tutorial.  To login, you need to establish a SSH connection from your laptop to the Frontera system.  Instructions depend on your laptop's operating system.

Mac / Linux:

|   Open the application 'Terminal'
|   ssh username@frontera.tacc.utexas.edu
|   (enter password)
|   (enter 6-digit token)


Windows:

|   If using Windows Subsystem for Linux, use the Mac / Linux instructions.
|   If using an application like 'PuTTY'
|   enter Host Name: frontera.tacc.utexas.edu
|   (click 'Open')
|   (enter username)
|   (enter password)
|   (enter 6-digit token)

When you have successfully logged in, you should be greeted with some welcome text and a command prompt.

**Example:**
To connect to the Frontera system:

::

    ssh username@frontera.tacc.utexas.edu

**Step 2: Request a Node**
Apptainer is only available on compute nodes at TACCs system.  To test container on our systems, we suggest launching an interactive session with idev. Below we request an interactive session on an gpu development node (-p rtx-dev) for a total time of 2 hours (-t 02:00:00). 

::

    $ idev -p rtx-dev -t 02:00:00

If prompted to use a reservation, choose yes. Once the command runs successfully, you have a shell on a dedicated compute node. Note, that you may need to wait for the compute to become available in the queue. 

**Step 3:  Load in Apptainer**

Once you have successfully have a shell launched on a compute node, you will need to load apptainer using module.  
::

    $ module list

    Currently Loaded Modules:
    1) intel/19.1.1   4) autotools/1.2   7) hwloc/1.11.12  10) tacc-apptainer/1.3.3
    2) impi/19.0.9    5) python3/3.7.0   8) xalt/2.10.34
    3) git/2.24.1     6) cmake/3.24.2    9) TACC

    
    $ module load tacc-apptainer

Now the apptainer command should be be available.  You can check by typing:
::

    $ type apptainer

    apptainer is /opt/apps/tacc-apptainer/1.3.3/bin/apptainer


**Step 4. Pull a Prebuilt PyTorch Docker Image**

Instead of creating our own Dockerfile, we can use an official PyTorch image from DockerHub

.. note::

    DockerHub is official cloud-based repository where developers store, share, and distribute Docker images. Similar to GitHub but for Docker containers.

Run the following command to pull the latest PyTorch image with CUDA support.

::
    
    apptainer pull output.sif docker://pytorch/pytorch:2.5.1-cuda12.4-cudnn9-devel

This will download the image and convert it into an Apptainer image format (.sif).
You can replace "output.sif" with whatever you would like to name the file. Otherwise it will default to the name of the image.

.. note:: 
    
    CUDA is an API that allows software to utilize NVIDIA GPUs for accelerated computing. This is essential for deep learning because GPUs process tasks much faster than CPUs.
    Since TACC machines have NVIDIA GPUs, we must use a CUDA-enabled PyTorch image to fully leverage GPU acceleration.



**Step 5. Start an Interactive Apptainer Shell**

Once the image is downloaded, we can enter the Apptainer shell by:

:: 

    $ apptainer shell output.sif

Now we are in our own isolated environment free to do whatever we would like with it.

**Step 6. Testing it Out**

    Once inside the container, switch over to your $SCRATCH directory and install this script. 

::

    $ git clone https://github.com/pytorch/examples.git

    $ torchrun --nproc_per_node=4 examples/distributed/ddp-tutorial-series/multigpu_torchrun.py 50 10


**Step 7: Verifying the Script Execution**
Once you've executed the script, you can check the output directly in your terminal. If there are any issues or errors, they will be displayed in the terminal.

Conclusion
----------
You have now successfully pulled a PyTorch image from Docker Hub, mounted local directories into the container, and run a Python script within an Apptainer container.

Special thanks to the Containers at TACC tutorial `<https://containers-at-tacc.readthedocs.io/en/latest/index.html>`_

For further help, refer to the official Apptainer documentation at: 
`<https://apptainer.org/docs>`_




First example, single node pytorch installation guide with just tacc machine
Look at gabriels doc for differnt pytorch images


Second example, build docker file on local, push to docker hub, pull onto tacc system




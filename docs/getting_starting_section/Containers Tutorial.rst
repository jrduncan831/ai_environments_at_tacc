Containers Tutorial
===================

Docker is a platform for developing, shipping, and running applications inside containers. Containers are lightweight, portable, and ensure that applications run consistently across different environments. However, since we will be working on TACC's HPC systems, this tutorial will be using Apptainer.

What is a Docker Image?
-----------------------
A Docker image is a pre-configured package that contains everything needed to run an application, including the code, runtime, libraries, and dependencies. Once an image is instantiated, it becomes a container, which is an isolated runtime environment.

Apptainer vs Container
----------------------
Apptainer (formerly Singularity) is a containerization platform designed specifically for high-performance computing (HPC) environments, offering a solution optimized for scientific research and large-scale data processing. Unlike general containers like Docker, which require root privileges and are commonly used for development and cloud-based applications, Apptainer is built to run efficiently on shared systems, such as TACC’s supercomputers and clusters. It provides portability, reproducibility, and seamless integration with HPC job schedulers making it ideal for researchers who need to run complex applications in secure, isolated environments without compromising performance or requiring administrative access.

Prerequisites
-------------
Before you begin, ensure that you have the following:
    - A working internet connection to download Docker.


Steps to Install PyTorch with CUDA on Docker
--------------------------------------------

we call it this but its not really ON docker or using docker other than docker hub, is this the intended tutorial? im not sure if i have it right
Apptainer runs Docker containers on HPC systems

**Step 1: Install Docker (if not already installed)**

    - `Mac <https://docs.docker.com/desktop/setup/install/mac-install/>`_
    - `Windows <https://docs.docker.com/desktop/setup/install/windows-install/>`_
    - `Linux <https://docs.docker.com/desktop/setup/install/linux/>`_


**Step 2: Run the SSH Command**  
Use the following command to connect to TACC systems:

:: 

    ssh <username>@<hostname>

(replace `<username>` with your TACC username and `<hostname>` with the system hostname)

**Example:**
To connect to the Frontera system:

::

    ssh username@frontera.tacc.utexas.edu

**Step 3: Enter Your Password**  
When prompted, type your TACC password. If this is your first time logging in, you may be required to set up or reset your password.

**Step 4: Two-Factor Authentication**  
TACC systems require two-factor authentication. Follow the on-screen prompts to complete the process.


**Step 5: Request a Node**
If you try to download a Docker image right off the bat, your terminal will warn you!

::

    (base) something$ idev -N 2 -n 2 -p rtx-dev -t 02:00:00

//explain what this means, the Flags
This might take a while but you will know that you have successfully loaded into a node when your command line shows (base) some numbers and what not

**Step 6:  Load in Apptainer**

::

    (base) something$ module list

    Currently Loaded Modules:
    1) intel/19.1.1   4) autotools/1.2   7) hwloc/1.11.12  10) tacc-apptainer/1.3.3
    2) impi/19.0.9    5) python3/3.7.0   8) xalt/2.10.34
    3) git/2.24.1     6) cmake/3.24.2    9) TACC

    
    (base) something$ module load tacc-apptainer

    verify with:
    (base) something$ type apptainer

    apptainer is /opt/apps/tacc-apptainer/1.3.3/bin/apptainer


**Step 5. Pull a Prebuilt PyTorch Docker Image**

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



**Step 7. Start an Interactive Apptainer Shell**

Once the image is downloaded, we can enter the Apptainer shell by:

:: 

    (base) something$ apptainer shell output.sif

Now we are in our own isolated environment free to do whatever we would like with it.

**Step 8. Testing it Out**

    Once inside the container, switch over to your $SCRATCH directory and install this script. 

::

    (base) soemthing$ git clone https://github.com/pytorch/examples.git

    (base) something$ torchrun --nproc_per_node=4 examples/distributed/ddp-tutorial-series/multigpu_torchrun.py 50 10


**Step 9: Verifying the Script Execution**
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


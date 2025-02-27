How to Install Conda
====================

Conda is a powerful package manager and environment management tool, widely used in data science and machine learning to manage dependencies and create isolated environments for different projects. This guide will walk you through the steps to install Conda on your system.

Prerequisites
-------------
Before you begin, ensure that you have the following:
    - A working internet connection to download Conda.
    - A terminal or command prompt to execute commands.

What is Conda-Forge and Mini-Forge?
-----------------------------------
Conda-Forge is a comunity-driven repository of conda packages. Mini-Forge is a lightweight installer for Conda, optimized to use Conda-Forge by default
For this guide's purposes, we will use MiniForge.

Steps to Install Conda
----------------------
**Step 1. Open a Terminal or Command Prompt.**

**Step 2: Run the SSH Command**  
Use the following command to connect to TACC systems:

:: 

    ssh <username>@<hostname>

(replace `<username>` with your TACC username and `<hostname>` with the system hostname)

**Example:**
To connect to the Frontera system:

::

    ssh username@frontera.tacc.utexas.edu

**Enter Your Password**  
When prompted, type your TACC password. If this is your first time logging in, you may be required to set up or reset your password.

**Step 3: Set Up Two-Factor Authentication**  
TACC systems require two-factor authentication. Follow the on-screen prompts to complete the process.

.. note::
   
    It is best practice to use the $WORK directory.

- Although in terms of I/O, **$SCRATCH** is actually the best place to install Conda and run subsequent tasks, files in this directory are routinely purged to save space. If you choose to install Conda in $SCRATCH, understand that you may have to re-install every so often.
- Ensure any output is bundled into a .tar file and moved into $WORK if using Conda for a high I/O task in $SCRATCH.
- **Placing Conda in $WORK is the best possible environment because it has enough storage capacity for Conda’s precompiled packages (NumPy, Tensorflow, etc.) but is not regularly purged.**

**Step 4. Install MiniForge**
Miniforge is a mini Conda installer that we can use as an alternative to Anaconda and Miniconda. We will be using it to download Conda into the $WORK directory.
We are going to install Conda in **Frontera** for the sake of this tutorial. When you SSH into Frontera, you will see this screen:

.. image:: images/conda-tut-1.png
   :alt: Frontera_home_screen

SSHing into Frontera takes you to the $HOME directory by default. Try running the **pwd (Print Working Directory)** command to see where you are:

.. image:: images/conda-tut-2.png
   :alt: PWD_command

As you can see, we are on home. We need to get into Work. **cd (change directory)** all the way back to the main directory of the system, so we can choose to install Conda on the $WORK directory. Here the working directory is also printed out to the screen with pwd to visualize going back in our directories:

.. image:: images/conda-tut-3.png
   :alt: CD_command

Let's see where our $WORK directory is. Use **ls -a (list all)** to view all files in the current directory:

.. image:: images/conda-tut-4.png
   :alt: ls_a_command

Notice how we have the disk options that were presented to us when we first logged onto Frontera available for us to cd into (home1, work2, and scratch1, scratch2, and scratch3).

These are the $HOME, $WORK, and $SCRATCH directories available for you specifically–and they may differ depending on the user.

Let's cd into **our specific work directory** with the following command:

::

    cd/work/#####/<username>

Where the numbers ##### will be your group number, and the username your TACC username.

When you get to your directory, you’ll see that you have multiple partitions available to you depending on the system you’re using:

.. image:: images/conda-tut-4.png
   :alt: partitions_available

This is a unique quality of the **$WORK** directories. Because they’re mounted in Stockyard and **shared across all systems**, you can access files from other systems with ease. We are on frontera, and we’ll be installing conda in the frontera work directory. Cd into frontera with:

::

    cd frontera

When you run pwd, your working directory should now be:

::

    /work/#####/<username>/frontera

Now that we’re in the work directory for frontera, we can install Conda. Use **curl** (a command-line tool to transfer data from a server via HTTP) to download Miniforge without having to download it to our local machine, which will come bundled with conda.

Run the following command in your terminal:

(You may also use wget if you prefer).

::

    curl -LO https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh

.. note::
    This download pulls it directly from the github link for the Linux architecture, which is what our systems use. If you follow this tutorial to install it on a local machine, you will need to change the URL to the installation file containing Miniforge for your system, which can be found in the same repo.
    The repository containing all installation packages for Miniforge can be found here:
    https://github.com/conda-forge/miniforge/releases

Now make the execution script executable with **chmod**, which modifies file permissions so that we can execute (**+x**) the file:

::

    chmod +x Miniforge3-Linux-x86_64.sh

Now we can run the Miniforge installer:

::

    bash Miniforge3-Linux-x86_64.sh

.. note::
    When you run the bash script, you will have some disclaimers pop up on your command line during the installation process. This disclaimer will walk you through the installation steps for Miniforge, but it will present to you a default installation folder that is in the **$HOME** directory.
    **Ensure you change this to your work/frontera directory before you install Miniforge.**

After running the bash script, it will ask you to update your shell profile to automatically initialize conda. **Type ‘yes’.**

**Step 5. Initialize Conda**
   After installation, initialize Conda to configure your shell:
    
    ::

        conda init

    Restart your terminal for the changes to take effect.

**Step 6. Verify the Installation**
    Confirm that Conda is installed by running:
    
    ::
        
        conda --version
    
    This should display the installed Conda version.

Congratulations! You now have Conda installed on your system.


Creating and Managing Environments
----------------------------------
Once Conda is installed, you can start creating and managing environments using the following commands:

1. **Create a new environment**:

    ::
        
        conda create --name myenv python

2. **Activate an environment**:

    ::
        
        conda activate myenv 

3. **Deactivate an environment**:

    ::

        conda deactivate

4. **Remove an environment**:

    ::
        
        conda remove --name myenv --all



Lets Install PyTorch
--------------------
Now that we have Conda installed, let's try installing PyTorch.

**Step 1. Create a Conda Enviornment**

::

    conda create --name pytorch_env python=3.10

Activate the environment

::

    conda activate pytorch_env

**Step 2: Install PyTorch**

::

    pip3 install torch==2.4.1 torchvision==0.17.1 torchaudio==2.4.1 --index-url https://download.pytorch.org/whl/cu126


Explanations:

- pytorch is the main library.

- torchvision provides utilities for computer vision tasks.

- torchaudio is for audio-related tasks.

- the link is a CUDA GPU specific version for our HPC purposes

**Optional: Manage Your Dependencies Using a YAML File**

If you would like, you can manage your Conda environments using a YAML file, which helps ensure consistency across different systems and distributed environments.

Typically, conda environments are managed in a file called **environment.yml**, which defines and manages dependencies, environments, and channels. Let’s manually create one–you will need vim or nano to do this through the command line.

**Step 1. Create an empty YAML File**
First, we'll need to create an empty environment.yml file to store our dependencies in with the following command:

::

    touch environment.yml


**Step 2. Add your environment variables to your YAML File**
Use the vim command **vim environment.yml** to open your environment file, then click the **insert** key on your keyboard to begin typing in these dependencies. When you are finished, click **esc** to get out of write mode, and then type in **:wq (write quick)** to save the contents of your file and exit out.

::

    name: pytorch_env
    channels:
        - pytorch
        - defaults
    dependencies:
        - python=3.10
        - pytorch
        - torchvision
        - torchaudio
        - cudatoolkit=12.6

**Step 3. Create your Conda environment with environment.yml**
Now that we have our environment.yml file created, we can activate it with:

::
    
    conda env create -f environment.yml

**Step 4. Activate Conda Environment**
Now that we have our **environment.yml** file created, we can activate it with:

::

    conda activate pytorch_env

Congrats! Now you have a conda environment made with those dependencies that is easily shared between users thanks to our YAML file.

**Step 5. Export your Conda Environment**
You can now share this environment easily between systems thanks to the environment.yml file.
Export it using the following command:

::
 
    conda env export > environment.yml

Running an Example script (multi_gpu_torchrun.py)
-------------------------------------------------
Now that we have created a Conda environment with Pytorch, we can try running an example script where we ensure that our environment works for multi-GPU training- a task with many applications in ML/AI in HPCs.
By downloading and running a python script from the official Pytorch repository called **multi_gpu_torchrun.py**, we can enable single training jobs to utilize multiple GPUs on a machine.

**This portion of the tutorial will require the use of Git- do not worry about downloading it. It is already installed on TACC systems!**

**Step 1. Clone the Pytorch Repository**
This is an official repository containing dozens of example scripts from the Pytorch library. For the purposes of this tutorial, we will be cloning it into the $WORK directory. Ensure you do not install it into the Conda environment!
::
    git clone https://github.com/pytorch/examples.git

**Step 2. CD into the ddp tutorial series folder**
Upon listing all of the directories now present in the **$WORK** folder, we should now see a new directory called **example**.
Now **cd** into the following directory:
::
    cd examples/distributed/ddp-tutorial-series

**Step 3. Use idev to request 2 nodes**
To test whether we can use multiple training GPUs, we'll first need to request 2 GPUs, which we will do through the idev tool.

.. note:
    If we don't specifically request 2 GPUs beforehand, when we run the multi_gpu_torchrun.py script, the program will run it on every GPU available. This may affect others using the GPU nodes on Frontera.



:: 

    conda activate pytorch_env

And within our virtual environment, we will use the **torchrun** command to launch the training script across 





For more information about multi-GPU training, see the following documentation: `Distributed Data Parallel in Pytorch`<https://pytorch.org/tutorials/beginner/ddp_series_intro.html>_

For more a more in-depth guide to using Conda, visit the official Conda documentation:  
`<https://docs.conda.io/>`_


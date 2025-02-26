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
.. image:: _static\images\conda-tut-1.png
   :alt: Frontera_home_screen

SSHing into Frontera takes you to the $HOME directory by default. Try running the **pwd (Print Working Directory)** command to see where you are:
.. image:: _static\images\conda-tut-2.png
   :alt: PWD_command

As you can see, we are on home. We need to get into Work. **cd (change directory)** all the way back to the main directory of the system, so we can choose to install Conda on the $WORK directory. Here the working directory is also printed out to the screen with pwd to visualize going back in our directories:
.. image:: _static\images\conda-tut-3.png
   :alt: CD_command

Let's see where our $WORK directory is. Use **ls -a (list all)** to view all files in the current directory:
.. image:: _static\images\conda-tut-4.png
   :alt: ls_a_command

Notice how we have the disk options that were presented to us when we first logged onto Frontera available for us to cd into (home1, work2, and scratch1, scratch2, and scratch3).

These are the $HOME, $WORK, and $SCRATCH directories available for you specifically–and they may differ depending on the user.

Let's cd into **our specific work directory** with the following command:
::
    cd/work/#####/<username>

Where the numbers ##### will be your group number, and the username your TACC username.

When you get to your directory, you’ll see that you have multiple partitions available to you depending on the system you’re using:
.. image:: _static\images\conda-tut-4.png
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
    *This download pulls it directly from the github link for the Linux architecture, which is what our systems use. If you follow this tutorial to install it on a local machine, you will need to change the URL to the installation file containing Miniforge for your system, which can be found in the same repo.
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
        
        conda create --name myenv

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
Now that we have Conda installed, lets try installing PyTorch

**Step 1. Create a Conda Enviornment**

::

    conda create --name pytorch_env python=3.10

Activate the environment

::

    conda activate pytorch_env

**Step 2: Install PyTorch**

::

    pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126


Explanations:

- pytorch is the main library.

- torchvision provides utilities for computer vision tasks.

- torchaudio is for audio-related tasks.

- the link is a CUDA GPU specific version for our HPC purposes

**Optional: Manage Your Dependencies Using a YAML File**

If you would like, you can manage your Conda environments using a YAML file, which helps ensure consistency across different systems.

**Step 1. Create a YAML File**

::

    conda env create -f environment.yml


**Step 2. Add your environmetn to your YAML File**

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

**Step .3 Export Your Current Environtment**

::
    
    conda env export > environment.yml



For more information, visit the official Conda documentation:  
`<https://docs.conda.io/>`_





//you can add in a yaml file like with virtual environments, to help manage, make it kind of a note, point them to the documentation if you want

//show them your own yaml file, explain more on why we use this if they need it
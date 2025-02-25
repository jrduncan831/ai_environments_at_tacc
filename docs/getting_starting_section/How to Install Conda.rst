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

**Step 3: Run the SSH Command**  
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

**Step 4: Set Up Two-Factor Authentication**  
TACC systems require two-factor authentication. Follow the on-screen prompts to complete the process.

.. note::
   
    It is best practice to use the $WORK directory.

Conda can create virtual environments, meaning you do not need to install it within a virtual environment, but it is highly advised you install it on the $WORK directory.


**Step 5. Install MiniForge**
    - Open your terminal or command prompt. Navigate to the directory where the installer was downloaded.
    - Run the installer command:
        
        - Mac/Linux: Use the terminal to run the installer:
        
        :: 

            bash Miniforge3-Linux-x86_64.sh  

        - Windows: Double-click the .exe file and follow the on screen instructions

**Step 6. Initialize Conda**
   After installation, initialize Conda to configure your shell:
    
    ::

        conda init

    Restart your terminal for the changes to take effect.

**Step 7. Verify the Installation**
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
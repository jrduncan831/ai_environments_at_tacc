Virtual Environments with Pytorch
=================================

Virtual environments are essential for isolating project dependencies and ensuring compatibility across different projects. This guide explains how to create a virtual environment using Python's built-in `venv` module.

Prerequisites
-------------
   - Python 3.3 or newer
   - A terminal or command prompt to execute commands.

.. note::
    Some parts of this tutorial require the use of Git, which is pre-installed onto TACC systems. 

Steps to Create and Activate a Virtual Environment
--------------------------------------------------

**Step 1. Connect to our systems.**
If you are unfamiliar with how to do this, please review the section called **Connecting to TACC**.

Once we have connected to TACC systems, we can now create the virtual environment.

.. note::
   
    It is best practice to use the $WORK directory to host our environment, since the $SCRATCH directory is regularly purged, and $HOME does not have the storage space for ML tasks.



**Step 3. Create the Virtual Environment**
   Run this command to create a virtual environment. You can replace 'myenv' with whatever you want to name your virtual environment.

   ::

         python3 -m venv myenv

**Step 4. Verify the Creation**
   After running the command, a new directory (e.g., `myenv`) will be created in your current location. This directory contains the files needed for the virtual environment.

    ::
        
        (base) UserName@System myenv % ls
        bin		include		lib		pyvenv.cfg

Understanding the Structure
^^^^^^^^^^^^^^^^^^^^^^^^^^^
The virtual environment directory contains:
   - **`bin` or `Scripts`**: Contains the executables, including the Python interpreter.
   - **`lib`**: Includes the standard library and site packages for your virtual environment.
   - **`pyvenv.cfg`**: Configuration file for the virtual environment.


**Step 5: Activate the environment**

    ::

        source myenv/bin/activate

Upon activation, you should see parentheses around the name of your environment appear in front of your working directory:

    ::
        
        (myenv) login3.frontera(470)$

In the next section, we will test this virtual environment by installing pytorch into it and then running an example script.

Testing our Virtual Environment with multigpu_torchrun.py
---------------------------------------------------------

To demonstrate how to use our virtual environment, we will download the multigpu_torchrun.py script from a github repository, install pytorch, and then run an example benchmarking function from the script, all within our virtual environment.

**multigpu_torchrun.py** is a script from the official pytorch repository that leverages distributed data parallel (DDP) to split ML training tasks across GPUs, allowing for a more efficient runtime. 

The multigpu_torchrun.py script can be found in the github repository below:

`https://github.com/pytorch/examples <https://github.com/pytorch/examples>`_


**Step 6. Download the repository containing code to run**
   You can download a github repository through the command line with the command **git clone**.

::

    git clone https://github.com/pytorch/examples.git

**Step 7. Request a Node through idev**
   To run our example script, we'll need to allocate a single node for the purposes of our task. One node on Frontera has 4 GPUs, which is adequate to run multigpu_torchrun.py's benchmarking function.

Begin your `idev <https://docs.tacc.utexas.edu/software/idev/>`_ session by running the following in your virtual environment:
::

    idev -N 1 -n 1 -p rtx-dev -t 02:00:00

This will request a **single compute node (-N 1 -n 1)** in the **rtx-dev** partition/queue **(-p)** for a time length of **two hours (-t 02:00:00).**
The rtx-dev queue is specifically for the NVIDIA RTX-5000 GPU compute nodes on Frontera systems, which are compatible with CUDA and pytorch by extension. To determine the queues and hardware specifications of TACC's HPC systems, see our `website <https://tacc.utexas.edu/systems/all/>`_ for more information.

When you request a node through idev, you will be taken to a loading screen. After your idev session starts, your current working directory will look like:

::

    (myenv) c196-011[rtx](452)$

This is how you will know your idev session has begun. **Ensure you see the (myenv) tag before your working directory. If you do not, activate your virtual environment again.** 

**Step 8. Download Pytorch into our Virtual Environment**
   To run multigpu_torchrun, we will need to install pytorch. Run the following pip command inside of your virtual environment:

::

    pip3 install torch torchvision torchaudio

**Step 9. CD into the ddp tutorial series folder**
   We should now see a new directory called **examples** present in our virtual environment.

**cd** into the following directory:

::
    
    cd examples/distributed/ddp-tutorial-series

*This will be a hidden directory.*

**Step 10. Run multigpu_torchrun.py**
   And within our virtual environment, we will use the **torchrun** command to launch the training script across all of the available nodes (1).

::

    torchrun --standalone --nproc_per_node=gpu multigpu_torchrun.py 5 10

This will distribute the training workload across all GPUs on your machine using `torch.distributed` and `DistributedDataParallel` (DDP), and train the model for 5 epochs and run checkpoints every 10 seconds.

When run successfully, you should get a result like this:

.. image:: images/multigpu_result.png
    :alt: multigpu_result

.. note::
    The task may take a few minutes to run.

Congratulations! You have now run a successful multi-GPU training task in a virtual python environment.

Deactivating a Virtual Environment
----------------------------------
When you’re done working in your virtual environment, you can deactivate it to return to the global Python environment:

1. Simply run the following command in your terminal (works on all operating systems):

    ::

        deactivate

2. You’ll notice the environment name disappears from your command line, confirming the environment has been deactivated.

Troubleshooting
---------------
- If the `activate` command is not recognized, ensure you’re in the correct directory where the virtual environment was created.

Congratulations! You now know how to activate, deactivate, and run code in a virtual environment to keep your Python projects organized and conflict-free.


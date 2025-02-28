Connecting to TACC
==================

The tutorials hosted on this website are designed for running ML tasks on TACC HPC systems specifically. A detailed outline for accessing our systems is present below.

Prerequisites
-------------
1. **TACC Account**  
    - If you haven't yet, create a TACC account `here <https://tacc.utexas.edu/portal/login?from=/portal/>`__.  

2. **SSH Client**  
    - **Linux/macOS**: Use the built-in terminal.  
    - **Windows**: Use Windows Terminal.
    - **Misc.**: VS Code, etc.

Connecting to TACC
------------------
**Step 1: Open Your Terminal of Choice**  
   
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

**Step 4: Set Up Two-Factor Authentication**  
TACC systems require two-factor authentication. Follow the on-screen prompts to complete the process.

Tips and Troubleshooting
------------------------
- If you cannot connect through SHH, verify your username, hostname, and network settings.
- If you run into issues while using a machine, try using the TACC-specific Sanitytool module to run diagnostics: `<https://docs.tacc.utexas.edu/include/sanitytool/>`
- Contact TACC support if you encounter further issues: `<https://portal.tacc.utexas.edu/help/>`_

Directories Explained
---------------------

While working on TACC systems, there are 3 main directories that users can utilize: $HOME, $WORK, and $SCRATCH. 

**Directories:** 
    - **$HOME**: Useful for projects needing small environments as $HOME does not have much storage. It's typically used for personal scripts, configuration files, and other small files that you want to persist over time.
    - **$WORK**: Useful for general projects that require more storage and can be considered semi-persistent. This directory is designed for active data or ongoing work that needs more space than $HOME, but is not temporary. Files here are not as likely to be purged, but users should still manage space appropriately.
    - **$SCRATCH**: Useful for work that may be discarded, as this directory is regularly purged. $SCRATCH is ideal for temporary files, large datasets, or computational outputs that do not need to be preserved. This space is designed for jobs in progress or interim work that will be cleaned up automatically to avoid storage overflow.

.. note::
    The $WORK environment is different from the $SCRATCH and $HOME environments because it is mounted on the global shared file system hosted on **Stockyard**–meaning it is available on Frontera, Stampede3, and most of our HPC systems.

$WORK is the **highest** directory on a global shared file system between several different HPC systems because it makes sharing between machines easy. The organization of the $WORK directory is outlined in the following diagram.

.. image:: images/stockyard-2022.jpg
   :alt: stockyard_roots

*image source*: `https://docs.tacc.utexas.edu/hpc/lonestar6/#files <https://docs.tacc.utexas.edu/hpc/lonestar6/#files>`_

.. note::
    Because work is such a large environment shared between so many users, the following problems may emerge:
    - **Constraints on Shared Resources** - Because so many users are running jobs on $WORK, high-intensity Input/Output (I/O) operations may cause performance bottlenecks and contention between users.
        - *One method of solving this is to **run high I/O operations in the $SCRATCH directory**, created for the specific purpose of not overloading the $WORK directory, and moving output files into $WORK.*
    - **Striping** - the $WORK file system has 24 I/O targets available, and stripe count should be adjusted accordingly. *It is generally advised to allocate at least one stripe for every 100 GB of file size, not exceeding 75% of available stripes.*

Working with Conda and Other ML Environments
--------------------------------------------
ML/AI tasks on TACC systems can require **heavy resource utilization** (for example, package installations and lookups, environment creation, etc.), and may lead to contention with other users. 

Additionally, since $WORK utilizes Lustre striping, performance is optimized for large files but can be inefficient for Conda environments, which contain thousands of small files.

Additional information about running Conda on TACC systems can be found in `How to Install Conda <ai_environments_at_tacc\docs\getting_starting_section\How to Install Conda.rst>`_, but for now, it is advisable to run Conda tasks in the $SCRATCH environment due to its high I/O load.

Requesting a Node to Work On
----------------------------
In a supercomputer, a node is usually a single computer or server in a cluster. A node on one of the TACC systems refers to an individual processor. Most of our systems are composed of **compute** nodes (for running tasks) and **login** nodes (for directing users and tasks towards the compute nodes).

In a typical HPC system, there are many more compute nodes than login nodes:

.. image:: images/hpc-schematic.jpg
   :alt: stockyard_roots

*image source*: `ekatsevi.github.io <https://ekatsevi.github.io/statistical-computing/hpc-basics.html#:~:text=Login%20nodes%20are%20like%20a,the%20workhorses%20of%20the%20HPC>`_

**It is important to avoid running tasks on the login nodes**, because this is where users will be waiting to queue their tasks. By running tasks on these login nodes, you’ll be taking a lot of computational resources away from users who are logging onto the system, and can affect the amount of time they will be waiting in the queue.

Each system has different kinds of nodes with different specifications for each, so if you want to understand how to fully utilize each system, you can find their documentation `here <https://tacc.utexas.edu/systems/all/>`__.

Requesting a Specific Node (GPU, CPU, etc.)
-------------------------------------------

**Why request a specific kind of node?**
Many TACC systems have both CPU and GPU nodes available to use. Matching your workload to the required hardware can help optimize compute time and take advantage of specific resources that your software might run on exclusively. (ex: how cuda exclusively runs on GPU hardware).

Through the TACC Analysis Portal (TAP)
--------------------------------------



Extra information
-----------------
For more information, visit the official TACC documentation:
`<https://www.tacc.utexas.edu/user-services/user-guides/>`_


Now we should request a Node to work on. You can do this by 


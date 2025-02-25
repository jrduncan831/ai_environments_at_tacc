Connecting to TACC
==================

All these tutorials will be configured to work specifically on TACC systems so before we proceed, here is a quick tutorial on how to access and work on TACC's systems.

Prerequisites
-------------
1. **TACC Account**  
    - If you haven't yet, create a TACC account `here <https://tacc.utexas.edu/portal/login?from=/portal/>`_.  

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
- If you cannot connect, verify your username, hostname, and network settings.
- Contact TACC support if you encounter issues: `<https://portal.tacc.utexas.edu/help/>`_

Directories Explained
---------------------

While working on TACC systems, there are 3 main directories that users will utilize. $HOME, $WORK, and $SCRATCH. 

Understanding the difference between the three are quite simple: 
    - **$HOME**: Useful for projects needing small environments as $HOME does not have much storage. It's typically used for personal scripts, configuration files, and other small files that you want to persist over time.
    - **$WORK**: Useful for general projects that require more storage and can be considered semi-persistent. This directory is designed for active data or ongoing work that needs more space than $HOME, but is not temporary. Files here are not as likely to be purged, but users should still manage space appropriately.
    - **$SCRATCH**: Useful for work that may be discarded, as this directory may get purged after a certain period. $SCRATCH is ideal for temporary files, large datasets, or computational outputs that do not need to be preserved. This space is designed for jobs in progress or interim work that will be cleaned up automatically to avoid storage overflow.

However, a potential issue with $WORK is that is you have a very large environment...continue this in conda's section to talk about being careful on where to install and work on projects ??

Extra information
-----------------
For more information, visit the official TACC documentation:
`<https://www.tacc.utexas.edu/user-services/user-guides/>`_


Now we should request a Node to work on. You can do this by 


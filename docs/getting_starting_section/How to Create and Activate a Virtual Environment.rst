How to Create and Activate a Virtual Environment
================================================

Virtual environments are essential for isolating project dependencies and ensuring compatibility across different projects. This guide explains how to create a virtual environment using Python's built-in `venv` module.

Prerequisites
-------------
   - Python 3.3 or newer installed on your system. (Usually pre-installed)
   - A terminal or command prompt to execute commands.

Steps to Create a Virtual Environment
-------------------------------------

1. **Open a Terminal or Command Prompt**
   Open the terminal (or Command Prompt on Windows), SSH onto a TACC machine, and navigate to the directory where you want to create the virtual environment.

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

**Step 4: Set Up Two-Factor Authentication**  
TACC systems require two-factor authentication. Follow the on-screen prompts to complete the process.

.. note::
   
    It would be best to use the $WORK directory


**Step 5. Create the Virtual Environment**
    Run this command to create a virtual environment. You can replace 'myenv' with whatever you want to name your virtual environment.

   ::

         python3 -m venv myenv

**Step 6. Verify the Creation**
   After running the command, a new directory (e.g., `myenv`) will be created in your current location. This directory contains the files needed for the virtual environment.

    ::
        
        (base) UserName@System myenv % ls
        bin		include		lib		pyvenv.cfg

Understanding the Structure
---------------------------
The virtual environment directory contains:
   - **`bin` or `Scripts`**: Contains the executables, including the Python interpreter.
   - **`lib`**: Includes the standard library and site packages for your virtual environment.
   - **`pyvenv.cfg`**: Configuration file for the virtual environment.


Virtual environments are an essential tool in Python development, allowing you to isolate project dependencies and avoid conflicts between different projects. This guide will walk you through the steps to activate a virtual environment.

Prerequisites
-------------
Before activating a virtual environment, ensure you have the following:
    - Python installed on your system.
    - A virtual environment created using `venv`.

Steps to Activate a Virtual Environment
---------------------------------------

.. note:: 
    
    Ensure you are SSH-ed into a TACC machine and in the proper directory.


1. Navigate to the directory containing your virtual environment using `cd`.
2. Run the following command:

    ::
            
        cd /path/to/your/environment

3. Activate the environment with:

    ::

        source /path/to/virtual-env/bin/activate

Replace `virtual-env` with the name of your virtual environment. For example in our previous tutorial, `myenv`

    ::
        
        (myenv) C:\Users\UserName\YourProject



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

Congratulations! You now know how to activate and deactivate a virtual environment to keep your Python projects organized and conflict-free.






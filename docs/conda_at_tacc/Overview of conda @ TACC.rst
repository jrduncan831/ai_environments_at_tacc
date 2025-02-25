Overview of conda @ TACC
========================


Using conda at TACC is a little tricky. The reason for this is that large conda environments, containing many thousands of files, can cause issues with the Lustre file system we have on several systems at TACC. In this tutorial we will discuss a few options you have for how to use conda on our systems in a way that avoids these issues.  In general, there are two ways to use conda: 

    1. Installed on our filesystems
    2. Installed inside of a container. 

Let’s start by discussing the best way to use conda outside of a container

Where to Install Conda Outside of a Container
---------------------------------------------
If we are using conda outside of a container, some thought needs to go into where to place it on our file systems (HOME, WORK, or SCRATCH).  No location is perfect– here are pros and cons of each:

    1. HOME 
        - Generally, you should not place conda in HOME unless the environment you build is very small due to the small quota in HOME. 
    2. SCRATCH
        - In terms of optimizing the I/O that takes place with conda, SCRATCH  is the correct location.  Unfortunately since SCRATCH can be purged, placing conda here is non-ideal.
    3. WORK
        - The best location to place conda is in WORK.  However, this also comes with its own problems.  If you have very large environments (many thousands of files) it does a number on the Lustre file system if you’re running lots of jobs in parallel.

For smaller jobs, we can get away with installing conda on WORK.  However, for jobs that require many jobs running in parallel, it is best to look for alternative solutions to setting up your environments.  Moving conda into containers in these scenarios is best.  Next, let’s take a look at an example of where we use miniforge within a container to build an environment. 

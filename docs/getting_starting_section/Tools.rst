Tools for AI/ML Environments
############################

Overview
========

This section provides an overview of several essential tools used to manage dependencies and environments when porting applications across different systems.

Containers
----------

Containers are lightweight, standalone packages that bundle an application with its runtime, system tools, libraries, and settings, ensuring consistent execution across environments. They function like efficient virtual machines, including the OS and dependencies for a reliable and portable deployment.


**Key Features**  
^^^^^^^^^^^^^^^^  
* **Complete and Portable Environment**: 
   Bundles the application with all necessary dependencies, making it portable across different systems.
* **Cross-Platform Consistency**: 
   Guarantees that applications will behave the same across various platforms, eliminating issues related to different configurations or system setups.
* **Cloud and Production-Ready**: 
   Widely used in cloud environments and for production deployments due to their efficiency and reliability (e.g., Docker).
* **Scalable**: 
   Ideal for scalable, microservice-based architectures and container orchestration tools like Kubernetes.


.. image:: https://containers-at-tacc.readthedocs.io/en/latest/_images/arch_container.png
   :alt: Applications isolated by containers.
   :width: 500px
   :align: center


Conda
-----

.. image:: images/Conda_logo.svg
   :align: center

Image source: `github.com/conda <https://github.com/conda>`_

Conda is a tool for managing and sharing packages and environments, making it easy to install dependencies and keep projects isolated. It is especially favored by data scientists and ML experts thanks to how it seamlessly handles library installation and environment creation.

**Key Features**  
^^^^^^^^^^^^^^^^  
* **Versatility**: 
   Allows the installation of both Python and non-Python packages.
* **Cross-Language Support**: 
   Supports a variety of programming languages- not just Python!
* **Environment Creation**: 
   Creates isolated environments for specific projects, ensuring that dependencies are managed separately for each.
* **Package Management**: 
   Unlike Python’s default package manager (pip), Conda's package manager also manages non-Python system dependencies, making it more comprehensive.


Virtual Environments
--------------------

Virtual environments are essential tools for isolating dependencies within Python projects. They allow developers to create distinct environments for each project, ensuring that dependencies do not conflict with one another.

**Key Features**  
^^^^^^^^^^^^^^^^  
* **Lightweight**: 
   Unlike Conda or containers, virtual environments in Python only manage Python libraries, which can make them lighter and faster to set up.
* **No System-Level Dependencies**: 
   Virtual environments do not handle non-Python system libraries or software dependencies.
* **Ideal for Small Projects**: 
   Best suited for smaller projects where only Python dependencies need to be isolated, without the complexity of managing other tools.

Compare & Contrast
==================

Each of these tools serves a distinct purpose, with specific use cases tailored to different needs in a project. While they can often be used together, each tool excels in a particular area of development or deployment.


Conda vs Virtual Environments
-----------------------------
* **Conda:** More versatile since it manages both environments and packages, not just for Python but other languages too. Ideal for larger projects or projects that require multiple languages. 
* **Virtual Environments:** Simpler and work better for smaller Python-only projects where we don't need to manage non-Python dependencies.

Conda vs Containers
-------------------
* **Conda:** Best for managing environments and packages in a development environment, especially for data science and machine learning. However, Conda environments are typically not as portable or lightweight as containers.
* **Containers:** Provides a more comprehensive solution by packaging not just dependencies but the entire application along with its environment, including the operating system. They are ideal for deployment and cross-platform consistency.

Containers vs Virtual Environments
----------------------------------
* **Containers:** Fully encapsulated and provide complete isolation, including the operating system, making them ideal for deployment and running applications consistently *across different systems.*
* **Virtual Environments:** Only isolates Python libraries and does not include system dependencies or the operating system itself. They are lightweight and easy to set up but are not as portable or complete as containers.

Commonplace Tools at TACC
=========================

While conda, virtual environments and containers can all be used on TACC systems, some are easier to use than others:

Virtual Environments and Containers 
-----------------------------------

When using Python for AI/ML applications, virtual environments are a great option. They allow you to isolate dependencies while also leveraging TACCs internal software that has been optimized for performance on our system.
Using containers is also highly recommended at TACC.  Please see `TACC's container tutorials <https://containers-at-tacc.readthedocs.io/en/latest/>`_ for more details. 

Conda
-----

Conda can be used to set up complex environments on non-HPC systems, but it is not optimized for use on HPC systems. If you would like to use Conda, view our tutorial on `How to Install Conda <\ai_environments_at_tacc\docs\getting_starting_section\How to Install Conda.rst>`_ for use on our systems as well as our advanced Conda section.  
This will give examples of various ways to install conda on our system to get the best performance. 

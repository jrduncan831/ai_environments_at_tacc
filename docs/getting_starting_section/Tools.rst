Tools for Managing AI/ML Environments
#####################################

Overview
========

This section provides an overview of several essential tools used in development and deployment workflows. These tools enable seamless management of dependencies, environments, and the portability of applications across different systems.

Containers
----------

Containers are lightweight, standalone, and executable software packages that include everything needed to run an application: the code, runtime, system tools, libraries, and settings. By packaging the application and its environment together, containers ensure that it runs consistently, regardless of the environment or infrastructure.
Additionally, they are essential performant virtual machines. The operating system (OS) is also bundled with the application and its dependencies, ensuring a comprehensive and consistent execution environment.


**Key Features**  
^^^^^^^^^^^^^^^^  
* **Complete and Portable Environment**: Bundles the application with all necessary dependencies, making it portable across different systems.
* **Cross-Platform Consistency**: Guarantees that applications will behave the same across various platforms, eliminating issues related to different configurations or system setups.
* **Cloud and Production-Ready**: Widely used in cloud environments and for production deployments due to their efficiency and reliability (e.g., Docker).
* **Scalable**: Ideal for scalable, microservice-based architectures and container orchestration tools like Kubernetes.


.. image:: https://containers-at-tacc.readthedocs.io/en/latest/_images/arch_container.png
   :alt: Applications isolated by containers.
   :width: 500px
   :align: center


Conda
-----

Conda is a powerful environment and package manager designed to handle not just Python dependencies but also other languages and tools. It is especially popular in data science and machine learning for managing complex projects with dependencies across multiple languages and systems.

**Key Features**  
^^^^^^^^^^^^^^^^  
* **Versatility**: Allows the installation of both Python and non-Python packages, making it suitable for managing projects in diverse ecosystems.
* **Cross-Language Support**: Supports a variety of programming languages, not limited to Python, which makes it ideal for multi-language projects.
* **Environment Isolation**: Creates isolated environments for specific projects, ensuring that dependencies are managed separately for each.
* **Data Science and ML Focus**: Conda simplifies the setup for data science and machine learning environments by handling complex dependencies across languages and tools.
* **Package Management**: Unlike Python’s default package manager (pip), Conda also manages non-Python system dependencies, making it more comprehensive.


Virtual Environments
--------------------

Virtual environments are essential tools for isolating dependencies within Python projects. They allow developers to create distinct environments for each project, ensuring that dependencies do not conflict with each other.

**Key Features**  
^^^^^^^^^^^^^^^^  
* **Python-Specific**: Virtual environments are designed exclusively for Python projects, isolating Python libraries and dependencies for each project.
* **Lightweight**: Unlike Conda or containers, virtual environments only manage Python libraries, which can make them lighter and quicker to set up.
* **No System-Level Dependencies**: Virtual environments do not handle non-Python system libraries or software dependencies.
* **Ideal for Small Projects**: Best suited for smaller projects where only Python dependencies need to be isolated without the complexity of managing other tools.

How They Are Different
======================

Each of these tools serves a distinct purpose, with specific use cases tailored to different needs in a project. While they can often be used together, each tool excels in a particular area of development or deployment.


Conda vs Virtual Environments
-----------------------------
* **Conda:** More versatile since it manages both environments and packages, not just for Python but other languages too. Ideal for larger projects or projects that require multiple languages. 
* **Virtual Environments:** More lightweight and Python-specific. Simpler and work better for smaller Python-only projects when we don't need to manage non-Python dependencies.

Conda vs Containers
-------------------
* **Conda:** Best for managing environments and packages in a development environment, especially for data science and machine learning. However, Conda environments are typically not as portable or lightweight as containers.
* **Containers:** Provides a more comprehensive solution by packaging not just dependencies but the entire application along with its environment, including the operating system. They are ideal for deployment and cross-platform consistency.

Containers vs Virtual Environments
----------------------------------
* **Containers:** Fully encapsulated and provide complete isolation, including the operating system, making them ideal for deployment and running applications consistently across different systems.
* **Virtual Environments:** Only isolates Python libraries and does not include system dependencies or the operating system itself. They are lightweight and easy to set up but are not as portable or complete as containers.

Which of these tools make sense to use at TACC?
===============================================

While conda, virtual environments and containers can all be used a at TACC they are not all created equal.  Below we will discuss each option and when it maybe appropriate to use on our systems 

Virtual Environments 
--------------------

When using Python for AI/ML applications, virtual environments are a great option. It allows you to isolate dependencies while also leveraging TACCs internal software that has been optimized for performance on our system.

Conda
-----
If you can set up your environment without using conda at TACC, we would suggest this.  Conda is set up to be incrediblely helpful setting up complex environments on our laptops, but is not optimized to run at HPC centers.  That being said, if you need to use conda at TACC, we hope this resource provides guidance on how to best use it. 

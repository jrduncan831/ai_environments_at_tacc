Miniforge with Sklearn
======================

Part 1: Interactively create container 
--------------------------------------

In this demo we will build a container with miniforge to run the following script:

**Python script: randomforest.py**

::

    #!/usr/bin/env python3
    from sklearn.ensemble import RandomForestClassifier
    from sklearn.datasets import load_iris
    from sklearn.model_selection import train_test_split
    from sklearn.metrics import accuracy_score

    # Load the iris dataset
    iris = load_iris()
    X = iris.data
    y = iris.target

    # Split the data into training and testing sets
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    # Create a random forest classifier
    rf = RandomForestClassifier(n_estimators=100, random_state=42)

    # Fit the model on the training data
    rf.fit(X_train, y_train)

    # Make predictions on the test data
    y_pred = rf.predict(X_test)

    # Evaluate the model's accuracy
    accuracy = accuracy_score(y_test, y_pred)
    print("Accuracy:", accuracy)


Miniforge offers a base container with mini-forge already installed.  This is a great base container for AI/ML environments that do not need GPUs.  To work through the dependencies for the script above let’s start an interactive session with this container.  Move to the directory where you have stored the script above and run the following command to launch docker.  Note that the -v $PWD:/code flag will mount the current working directory into the container so our script will be accessible.

::

    docker run -it -v $PWD:/code condaforge/miniforge3 /bin/bash

If this is your first time using this the miniforge container, then Docker will download the image first. Once the image is downloaded and running the command prompt will change once you are inside the image. 

::

    (base) root@a236fcd347ef:/#

Next, we can see what the default version of python is in the base container.

::

    (base) root@a236fcd347ef:/# python --version
    Python 3.12.7

Next we need to create the conda environment we plan to utilize for the script above.  We can see the dependencies of this script is pandas and scikit-learn and we would like to use an older version Python, say 3.11. 

::

    (base) root@5cd481291891:/# conda create -n myenv python=3.11 scikit-learn pandas

To utilize this environment, we need to activate the environment:

::

    (base) root@5cd481291891:/# conda activate myenv

When the environment is activated, we should see that base has been replaced with myenv:

::

    (myenv) root@5cd481291891:/# python --version
    Python 3.11.11  

Finally, we can install and test our code 

::

    (myenv) root@5cd481291891:/# cd code/ 
    (myenv) root@5cd481291891:/code# chmod +rx randomforest.py 
    (myenv) root@5cd481291891:/code# export PATH=/code:$PATH
    (myenv) root@5cd481291891:/code# cd
    (myenv) root@5cd481291891:/code# randomforest.py
    Accuracy: 1.0

We have successfully created a container and ran our example script.  Next, let’s build the same container with a Dockerfile 

**Part 2: Build container with a Dockerfile**

Now that we have interactively created our docker container, let’s put all the steps into a docker file.  Note I modified the Docker file to create the environment from a yml file where the yml file contains:

::

    YML

    name: myenv
    dependencies:
    - scikit-learn
    - pandas 


::

    DOCKERFILE

    FROM condaforge/miniforge3

    # from yml file
    COPY environment.yml .
    RUN conda env create -f environment.yml

    # This line will change the shell launched when opening the container such that
    # the environment created above is activated  
    RUN echo "source activate myenv" > ~/.bashrc

    # Copy files Files you want to run,  make executable, and add code to $PATH
    COPY randomforest.py /code/randomforest.py
    RUN chmod +rx /code/randomforest.py
    ENV PATH="/code:$PATH"


A few important notes about the above Dockerfile

1. We can create conda environments in various ways, but one convenient way is using a yml file.  We switch to this in the Dockerfile above. 
2. To activate the conda environment we create, you can set up a bash configuration file that activates the environment.  

To test this container first ensure your dockerfile and script file are in the current working directory, then build the container via the following command: 

::
    
    docker build --platform [architecture] -t [username]/[container name]:[tag] . 

Then run it by having it open shell:

::
    
    docker run --rm -it condatest /bin/bash

When launching the container you should see that myenv is activated. Then, we can run the randoforest.py script:

::
    
    (myenv) root@ca6bcb7e8f60:/# randomforest.py
    Accuracy: 1.0

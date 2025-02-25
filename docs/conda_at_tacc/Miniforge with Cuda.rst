Miniforge with Cuda
===================

DOCKERFILE
----------

::

    ###################################################
    # 1. Use Cuda Base Image
    FROM nvcr.io/nvidia/cuda:12.4.1-runtime-ubuntu22.04
    ###################################################

    ###################################################
    # 2. Install Miniforge
    RUN apt-get update
    RUN apt-get install -y wget
    RUN wget "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
    RUN bash Miniforge3-$(uname)-$(uname -m).sh -b -p /opt/conda
    # Add Conda to PATH
    ENV PATH=/opt/conda/bin:$PATH
    #initialize and update conda
    RUN conda init
    RUN conda update -n base -c conda-forge conda
    ###################################################

    ###################################################
    # 3. create gpu enabled environment
    ENV CONDA_OVERRIDE_CUDA=12.4
    RUN conda install -c conda-forge py-xgboost-gpu cupy
    ###################################################

    ###################################################
    # This line will change the shell launched when opening the container such that
    # the environment created above is activated  
    RUN echo "source activate base" > ~/.bashrc
    ###################################################

    ###################################################
    # Copy files Files you want to run,  make executable, and add code to $PATH
    COPY test.py /code/test.py
    RUN chmod +rx /code/test.py
    ENV PATH="/code:$PATH"
    ###################################################

PYTHON SCRIPT 
-------------

::

    from xgboost import XGBClassifier
    from sklearn.datasets import load_iris
    from sklearn.model_selection import train_test_split
    from sklearn.metrics import accuracy_score
    import cupy as cp

    # get data
    data = load_iris()

    # test train split
    X_train, X_test, y_train, y_test = train_test_split(data['data'], data['target'], test_size=.2)

    # create model instance
    bst = XGBClassifier(n_estimators=2, max_depth=2, learning_rate=1, objective='binary:logistic',device='cuda')

    # fit model
    bst.fit(X_train, y_train)

    # make predictions
    y_pred = bst.predict(X_test)

    # compute accuracy
    print('Accuracy:{}'.format(accuracy_score(y_test, y_pred)))

Ensure your python script test.py is in the same directory as your dockerfile.  The dockerfile above can be used to run and test the given Python script.  In this example we need to build a GPU enabled XGBoost environment.  To build the Docker file for this we can think of it in 5 steps:

1. Figure out what version of CUDA is appropriate for the system you are using as well as the software you will be utilizing.  Use this version of CUDA as your base image 
2. Install and activate miniforge 
3. Create conda environment for your application.  Note by default conda does not install gpu-enabled code on a device without a GPU.  To override this feature, you can set the CONDA_OVERRIDE_CUDA environment variable.  See conda docs for more detail. You will need to use this environment variable if you are building this environment on a device without a GPU.
4. Setup a bash configuration file that activates the environment. 
5. Optional: copy and set up file you would like to run on the container


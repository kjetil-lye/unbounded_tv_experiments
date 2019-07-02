# unbounded_tv_experiments
Experiments for the unbounded tv norm paper

## Getting Docker

[Consult the online documentation](https://docs.docker.com/install/). Install the CE (Community Edition) version.

These files were last tested with

    Docker version 18.09.1-ce, build 4c52b901c6


## Running in Docker

This guide assumes you are running a POSIX-compliant shell (eg. BASH). If not, replace ```$(pwd)``` with the full path to the notebook folder, ```$(dirname $(pwd))``` with the complete path to this repository, and ```$(user -id)``` with the ID of the current user. If you are using OS X or Linux, you have POSIX complaint shell. If you are using Windows, you can get one by installing eg. BASH from the git package.

Go to the ```notebook``` folder in the command line, and run

    docker run -p 8888:8888 --rm -w $(pwd) -e "HOME=$(pwd)" -e "ALSVINN_BUILD_PATH=/alsvinn/build_docker" -v $(dirname $(pwd)):$(dirname $(pwd)) --user $(id -u) -it --entrypoint 'jupyter' alsvinn/alsvinn_cpu:release-0.5.3  notebook --ip=0.0.0.0 

To make life easier for everyone, we have made a script in the ```notebook``` folder, so you can simply run

    bash run_notebook_from_docker.sh



You will get output of the form


    [I 16:02:40.419 NotebookApp] Serving notebooks from local directory: /home/kjetil/projects/unbounded_tv_experiments/notebooks
    [I 16:02:40.419 NotebookApp] The Jupyter Notebook is running at:
    [I 16:02:40.420 NotebookApp] http://(b6b71ac867b9 or 127.0.0.1):8888/?token=52178bd3b7b268da88d26c69347fc697edd5c00cc5f5524b
    [I 16:02:40.420 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
    [W 16:02:40.424 NotebookApp] No web browser found: could not locate runnable browser.
    [C 16:02:40.424 NotebookApp] 
    
        To access the notebook, open this file in a browser:
            file:///home/kjetil/projects/unbounded_tv_experiments/notebooks/.local/share/jupyter/runtime/nbserver-1-open.html
        Or copy and paste one of these URLs:
            http://(b6b71ac867b9 or 127.0.0.1):8888/?token=52178bd3b7b268da88d26c69347fc697edd5c00cc5f5524b

Open a web browser on your computer and enter the address

     http://127.0.0.1:8888/?token=TOKEN_FROM_OUTPUT

with the above output ```TOKEN_FROM_OUTPUT``` would bee ```52178bd3b7b268da88d26c69347fc697edd5c00cc5f5524b``` (this changes for every run).

Open the notebook ```run_tv_experiments.ipynb``` and run all cells in order.

## Running without Docker

First download and compile [Alsvinn](https://github.com/alsvinn/alsvinn) (last tested with version 0.5.3), then make sure the ```PYTHONPATH``` contains the ```python``` folder of the ```build``` folder:

    export PYTHONPATH=$PYTHONPATH:<path to build folder of alsvinn>/python

Then make sure you have the necessary packages installed (see ```requirements.txt```). From the ```notebook``` folder, run ```jupyter notebook``` and open ```rurn_tv_experiments.ipynb```. Run the cells in order. 

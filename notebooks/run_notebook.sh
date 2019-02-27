#!/bin/bash
set -e
if [ -z "$ALSVINN_BUILD_PATH" ]
then
    echo "Missing ALSVINN_BUILD_PATH from ENV"
    echo "Set it using"
    echo "    export ALSVINN_BUILD_PATH=<path to build folder of alsvinn>"
    exit 1
fi

if [ ! -f ${ALSVINN_BUILD_PATH}/python/alsvinn/alsvinn.py ]
then
    echo "Missing 'python/alsvinn/alsvinn.py' from ALSVINN_BUILD_PATH"
    echo '${ALSVINN_BUILD_PATH} should contain the build folder of alsvinnn'
    echo "Now it is set to ${ALSVINN_BUILD_PATH}"
    echo ""
    echo "Set it with"
    echo "    export ALSVINN_BUILD_PATH=<path to build folder of alsvinn>"
    exit 1
fi

$HOME/.local/bin/jupyter nbconvert --ExecutePreprocessor.timeout=-1 --to notebook --execute run_tv_experiments.ipynb --output run_tv_experiments_output.ipynb


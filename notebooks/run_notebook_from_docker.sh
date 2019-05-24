#!/bin/bash
set -e
docker run -p 8888:8888 --rm -w $(pwd) -e "HOME=$(pwd)" -e "ALSVINN_BUILD_PATH=/alsvinn/build_docker" -v $(pwd):$(pwd) --user $(id -u) -it --entrypoint 'jupyter' alsvinn/alsvinn_cuda:release-0.4.1  notebook  --ip=0.0.0.0

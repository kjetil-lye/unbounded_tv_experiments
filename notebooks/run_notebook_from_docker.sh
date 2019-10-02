#!/bin/bash
set -e
docker run -p 8888:8888 --rm -w $(pwd) -e "HOME=$(pwd)" -e "ALSVINN_BUILD_PATH=/alsvinn/build_docker" -v $(dirname $(pwd)):$(dirname $(pwd)) --user $(id -u) -it --entrypoint 'jupyter' alsvinn/alsvinn_cpu:release-0.5.4  notebook  --ip=0.0.0.0

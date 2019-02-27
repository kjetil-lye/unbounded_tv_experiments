#!/bin/bash
set -e
for x in img/*.png;
do

    convert $x -resize 25% img_downscaled/${x//img\//}
done

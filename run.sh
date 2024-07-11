#!/usr/bin/env sh

image_list=$(ls -1 data/*jpg data/*png 2>/dev/null)

for image in $image_list ; do
    fbase="${image%.*}"
    fextension="${image##*.}"
    out_image="${fbase}_out.${fextension}"
    echo "Processing Image: $image -> ${out_image}"
    bin/mosaic.exe "$image" "${out_image}"
done


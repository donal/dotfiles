#!/bin/bash

for f in *
do
  ext=${f:(-3)}
  name=${f::${#f}-4}
  if [ $ext = "txt" ]; then
    # echo $name.$ext $name.md
    git mv $name.$ext $name.md
  fi
done

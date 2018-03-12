#!/bin/bash

moving=$(ls -lrt ~/Downloads | tail -1 | rev | cut -d' ' -f1 | rev)

moving="${moving#\/}"

echo $moving

if [[ $moving != "github" ]]; then
  echo "moving $moving"
  mv $moving /Users/donal/Downloads/github
else
  echo "trying to move the github directory into the github directory—this won't work"
  exit 1
fi


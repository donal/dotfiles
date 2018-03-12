#!/bin/bash
echo $(ls -lrt /Users/donal/Downloads | tail -1 | rev | cut -d' ' -f1 | rev)

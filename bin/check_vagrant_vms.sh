#!/bin/bash

echo 'check for running vagrant vms'

function check_if_vm_is_running {
  if vagrant status | grep "^default" | grep -q "not running"; then
    echo "$1 not running"
  else
    echo "$1 running"
  fi
}

for dir in /Users/donal/dev/vms/vagrants/*; do
  if [ -d "$dir" ]; then
    cd "$dir"
    if [ -f "$dir/Vagrantfile" ]; then
      check_if_vm_is_running $dir
    fi
  fi
done


#!/bin/bash
#/
#/ Usage: mves [OPTIONS] <company>
#/
#/ Move latest downloaded bundle into place.
#/
#/ OPTIONS:
#/   -h | --help                             Show this message.
#/   -b <filename> | --bundle <filename>     Bundle filename.
#/   <company>                               Company name, which becomes name of destination.
#/

# TODO
# command should take company name as input
# create ~/Downloads/<name> directory
# return error if it already exists
# find most recent support bundle
# use github-support-bundle.tgz
# mv and extract it to the <name> directory

# actually could you read the bundle (extract to tmp dir) to work out company
# name?

# these sort of things would make good programming exercises

# set -e

usage() {
  grep '^#/' < $0 | cut -c4-
}

BUNDLE=""
COMPANY=""
DOWNLOAD_DIR="/Users/donal/Downloads"

while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help)
        usage
        exit 2
        ;;
    -b|--bundle) # bundle filename
      BUNDLE=$2
      shift 2
      ;;
    *)
      if [ -z "$COMPANY" ]; then
          COMPANY="$1"
          shift
      else
          echo 1>&2 "error: invalid argument: $1"
          exit 1
      fi
      ;;
  esac
done

if [ -z "$COMPANY" ]; then
  echo "Error: company not specified" >&2
  usage
  exit 1
fi

if [ -z "$BUNDLE" ]; then
  BUNDLE="github-support-bundle.tgz"
fi

BUNDLE_FILE="$DOWNLOAD_DIR/$BUNDLE"
entry=$(ls -lrt "$BUNDLE_FILE" 2>/dev/null)

if [[ $entry ]]; then
  echo "$BUNDLE exists"
  moving=$(ls -lrt "$BUNDLE" | tail -1 | rev | cut -d' ' -f1 | rev)
  echo "moving $moving"
  moving="${moving#\/}"
#   mv $moving /Users/donal/Downloads/github

else
  echo "$BUNDLE doesn't exist"
fi


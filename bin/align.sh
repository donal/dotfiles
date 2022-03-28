FILE=$1
sed 's/,/+,/g' $FILE | column -t -s+ | sed 's/ ,//g'


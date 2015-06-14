#!/bin/bash

# Origianl version : http://www.keepthingssimple.net/2012/10/creating-requests-per-time-graph-from-nginx-or-apache-access-log/ 
# This version is a port to Mac OSX
# dreampuf (http://huangx.in)

# useage :
#   graphit.sh logfile.log
#   open result-2013-06-04.png 

FILE=$1
FDATE=$(head -1 $FILE |awk '{print $4}'|sed -e 's/\[//'|sed -e 's/\]//'|sed -e 's/\//-/g'|sed -e 's/:/ /')
FDATE_S=$(date -j -f "%d-%b-%Y %H:%M:%S" "$FDATE" "+%s");
FDATE_T=$((FDATE_S + 300));
COUNT=0
 
DATAFILE=$(mktemp -t /tmp)
RESULTFILE="result-"$(date -r $FDATE_S '+%Y-%m-%d')".png"
 
while read line
do
    LDATE=$(echo $line|awk '{print $4}'|sed -e 's/\[//'| sed -e 's/\]//' |sed -e 's/\//-/g'|sed -e 's/:/ /')
    echo $LDATE
    LDATE_S=$(date -j -f "%d-%b-%Y %H:%M:%S" "$LDATE" '+%s');
    if (( LDATE_S < FDATE_T )); then
        COUNT=$((COUNT + 1))
    else
        echo "$(date -r "$((FDATE_T - 300))" '+%Y-%m-%d %H:%M:%S') $COUNT" >> $DATAFILE
        FDATE_T=$((FDATE_T + 300))
        COUNT=1;
    fi
done <$FILE
 
gnuplot << EOF
reset
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set format x "%H:%M"
set autoscale
set ytics
set grid y
set auto y
set term png truecolor
set output "$RESULTFILE"
set xlabel "Time"
set ylabel "Request per 5min"
set grid
set boxwidth 0.95 relative
set style fill transparent solid 0.5 noborder
plot "$DATAFILE" using 1:3 w boxes lc rgb "green" notitle
EOF
 
#rm -f $DATAFILE

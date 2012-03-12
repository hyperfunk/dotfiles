#!/bin/zsh
#
# Usage: ./bar.sh [<desktop_number>]
#
# Creates a clickable dzen bar that allows switching between desktops,
# optionally switching to the given desktop.

FG_FOCUS="#F0DFAF"
BG_FOCUS="#1E2320"

#Launch dzen2 and establish the pipe
if [[ ! -e /tmp/dzen2.pipe ]]
then
  socat -v PIPE:/tmp/dzen2.pipe EXEC:"dzen2 -p -ta l -x 0 -w 200 -fn -xos4-terminus-medium-r-normal--12-140-72-72-c-80-iso8859-1"&
fi

#Switch to the given desktop
if [[ ! -z $1 ]]
then
  wmctrl -s $1
fi

#Get all desktop names
DESKTOPS=(`wmctrl -d | cut -d\  -f13`)

#Create the dzen input
#The click action calls the script with argument the clicked desktop, and
#thus both swithes to this desktop and updates the dzen bar.
#
#The wm mappings to switch between desktop should call this script as well
line=""
for d in $DESKTOPS
do
  switchTo=`wmctrl -d | grep $d | cut -d\  -f1`
  if [[ -z "`wmctrl -d | grep $d | grep '*'`" ]]
  then
    line+="^ca(1,./bar.sh $switchTo)$d^ca()"
  else
    line+="^ca(1,./bar.sh $switchTo)^bg($BG_FOCUS)^fg($FG_FOCUS)$d^fg()^bg()^ca()"
  fi
done

#Forward the dzen input to dzen through the pipe
while true; do
    echo $line 
    sleep 1
done | dzen2 -ta l -x 0 -w 200 -fn -xos4-terminus-medium-r-normal--12-140-72-72-c-80-iso8859-1
#socat - PIPE:/tmp/dzen2.pipe

sleep 10
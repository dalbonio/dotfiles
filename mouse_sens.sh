#!/bin/sh

Mouse=`xinput list |grep -i Logitech | awk -F= '{ print $2}'| awk '{print $1}'| awk 'BEGIN{ RS = "" ; FS = "\n" }{print $1}'`

xinput set-prop $Mouse "Coordinate Transformation Matrix" .2 0 0 0 .2 0 0 0 1

#!/bin/bash

SRC=$1
STYLE=$2
DST=$3
# TODO: check $SRC $STYLE $DST validity

# get suffix
SUFFIX_SRC=$(echo $SRC | grep -o '\.[^\.]*$')
SUFFIX_STYLE=$(echo $STYLE | grep -o '\.[^\.]*$')
SUFFIX_DST=$(echo $DST | grep -o '\.[^\.]*$')

ROW=2
COLUMN=2
# TODO: customizable split configuration

# create temporary directories

DIR=$(mktemp -d)
DIR_SRC=$DIR/src
DIR_STYLE=$DIR/style
DIR_DST=$DIR/dst

mkdir -p $DIR_SRC $DIR_STYLE $DIR_DST

# split $SRC

echo python split.py "$SRC" $ROW $COLUMN $DIR_SRC $SUFFIX_SRC
pdb split.py "$SRC" $ROW $COLUMN $DIR_SRC $SUFFIX_SRC

# split $STYLE

echo python split.py "$STYLE" $ROW $COLUMN $DIR_STYLE $SUFFIX_STYLE

# stylize splited $SRC & $STYLE

for ((i=0; i < ROW*COLUMN; i++)); do
	echo python stylize.py $DIR_SRC/$i$SUFFIX_SRC $DIR_STYLE/$i$SUFFIX_STYLE $DIR_DST/$i$SUFFIX_DST
done

# merge back

echo python merge.py "$DST" $ROW $COLUMN $DIR_DST $SUFFIX_DST

# clean up

# rm -r $DIR

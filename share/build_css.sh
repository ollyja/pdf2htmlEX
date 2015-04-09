#!/bin/sh -ex
# Compile and optimize CSS code
# Copyright 2013 Lu Wang <coolwanglu@gmail.com>


BASEDIR=$(dirname $0)
YUI_DIR="$BASEDIR/../3rdparty/yuicompressor"
YUI_JAR="$YUI_DIR/yuicompressor-2.4.8.jar"

# when running in cygwin environment, we have to convert to windows path 
if [ "$(expr substr $(uname -s) 1 6)" == "CYGWIN" ];then
    # use 2.4.7 on windows as 2.4.8 cannot handle absolute output path 
    YUI_JAR="$YUI_DIR/yuicompressor-2.4.7.jar"
    YUI_JAR=$(cygpath -w $YUI_JAR)
fi 

build () {
    INPUT="$BASEDIR/$1"
    OUTPUT="$BASEDIR/$2"

    # set input/output parameter 
    PINPUT="$BASEDIR/$1"
    POUTPUT="$BASEDIR/$2"

    # convert to windows path 
    if [ "$(expr substr $(uname -s) 1 6)" == "CYGWIN" ];then
      PINPUT=$(cygpath -w $INPUT)
      POUTPUT=$(cygpath -w $OUTPUT)
    fi 

    (echo "Building $OUTPUT with YUI Compressor" && \
        java -jar "$YUI_JAR" \
             --charset utf-8 \
             --type css \
             -o $POUTPUT \
             $PINPUT && \
        echo 'Done.') || \
    (echo 'Failed. ' && \
    echo 'Using the uncompressed version.' && \
    cat "$INPUT" > "$OUTPUT")
}

build "base.css" "base.min.css"
build "fancy.css" "fancy.min.css"

# build pdf.css which includes both base.min.css and fancy.min.css 
cat $BASEDIR/base.min.css > $BASEDIR/pdf.css
#cat $BASEDIR/fancy.min.css >> $BASEDIR/pdf.css

#!/bin/sh -ex
# Compile and optimize JS code
# Copyright 2013 Lu Wang <coolwanglu@gmail.com>

# To enable closure-compiler, you need to install and configure JAVA environment
# Read 3rdparty/closure-compiler/README for details


BASEDIR=$(dirname $0)
CLOSURE_COMPILER_DIR="$BASEDIR/../3rdparty/closure-compiler"
CLOSURE_COMPILER_JAR="$CLOSURE_COMPILER_DIR/compiler.jar"

# when running in cygwin environment, we have to convert to windows path 
if [ "$(expr substr $(uname -s) 1 6)" == "CYGWIN" ];then
     CLOSURE_COMPILER_JAR=$(cygpath -w $CLOSURE_COMPILER_JAR)
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

    (echo "Building $OUTPUT with closure-compiler..." && \
      java -jar "$CLOSURE_COMPILER_JAR" \
         --compilation_level ADVANCED_OPTIMIZATIONS \
         --warning_level VERBOSE \
         --output_wrapper "(function(){%output%})();" \
         --js "$PINPUT" \
         --js_output_file "$POUTPUT" && \
      echo 'Done.') || \
    (echo 'Failed. Read `3rdparty/closure-compiler/README` for more detail.' && \
    echo 'Using the uncompressed version.' && \
    cat "$INPUT" > "$OUTPUT")
}

build "pdf2htmlEX.js" "pdf2htmlEX.min.js"

# build pdf.min.js (include both pdf2htmlEX.min.js and compatibility.min.js
cat $BASEDIR/../3rdparty/PDF.js/compatibility.min.js > $BASEDIR/pdf.min.js
cat $BASEDIR/pdf2htmlEX.min.js >> $BASEDIR/pdf.min.js

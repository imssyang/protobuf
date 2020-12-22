#!/bin/bash

export PROTOBUF_DISABLE_ENV=no

if [[ -z $CLASSPATH ]]; then
  export CLASSPATH=.:/opt/protobuf/lib/protobuf-java-3.14.0.jar
else
  export CLASSPATH=.:/opt/protobuf/lib/protobuf-java-3.14.0.jar:$CLASSPATH
fi


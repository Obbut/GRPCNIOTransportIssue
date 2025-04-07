#!/bin/bash

grpcurl -protoset=Sources/HelloWorldProto/hello_world.protoset \
    -plaintext \
    -d '{"name": "World"}' \
    127.0.0.1:8080 \
    helloworld.Greeter/SayHello

#!/bin/bash

for i in {1..100}; do
    for i in {1..100}; do
        grpcurl -protoset=Sources/HelloWorldProto/hello_world.protoset \
            -plaintext \
            -d '{"name": "World"}' \
            127.0.0.1:8080 \
            helloworld.Greeter/SayHello
    done
    wait
done

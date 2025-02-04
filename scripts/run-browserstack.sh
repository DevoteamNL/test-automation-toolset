#!/bin/bash

app=$1
cd browserstack/$app && browserstack-node-sdk node ../../tests/mobile/$app/sample_test.js
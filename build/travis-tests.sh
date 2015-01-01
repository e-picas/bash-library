#!/bin/bash

git submodule init
git submodule update
./build/run-tests.sh

#!/bin/bash

one=$1
two=$2

awk -v o="$one" -v t="$two" '$NF>o && $1>t {print}' testtxt

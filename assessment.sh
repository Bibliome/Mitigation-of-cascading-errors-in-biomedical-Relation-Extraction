#!/bin/env bash

ALVISNLP=/home/rbossy/code/alvisnlp/.test/alvisnlp/bin/alvisnlp

MODE=$1

$ALVISNLP -inputDir 0-data/BioNLP-OST-2019_BB-rel+ner/dev -inputDir . -alias deferred-dir 1-assessment/deferred/dev/Lives_In/$MODE alvisnlp/assessment.plan

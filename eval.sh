#!/bin/env bash

SET=$1
shift

java -jar bionlp-st-core-0.1-standalone.jar -task BB19-rel+ner -$SET -alternate -prediction 0-data/BioNLP-OST-2019_BB-rel+ner/$SET/pred/ $@

#!/bin/env bash

#SBATCH --job-name=anlp-test
#SBATCH --output=run.out
#SBATCH --error=run.err
#SBATCH --ntasks=1
#SBATCH --gres=gpu:1
#SBATCH --partition=testing
#SBATCH --qos=debug

ALVISNLP=/mnt/beegfs/projects/alvisnlp/src/alvisnlp/.test/alvisnlp/bin/alvisnlp-0.11.0-SNAPSHOT

SET=$1
DATA_DIR=0-data/BioNLP-OST-2019_BB-rel+ner/$SET

srun $ALVISNLP -inputDir $DATA_DIR -inputDir . -outputDir $DATA_DIR alvisnlp/predict.plan
srun ./eval.sh $SET -tabular > $DATA_DIR/eval.tsv
srun ./eval.sh $SET -pairing > $DATA_DIR/pairing.tsv

. config.sh

$PYTHON $REBERT_DIR/eval.py --data_dir $DATA_FILE --model_type biobert --config_name_or_path $REBERT_DIR/config/biobert.json --pretrained_model_path $REBERT_DIR/pretrained_model --finetuned_model_path $FINETUNED_MODEL --num_labels 2 --ensemble_models 6 $FORCE_CPU --output_dir $OUTPUT_DIR

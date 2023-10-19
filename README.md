# Mitigation of cascading errors in biomedical Relation Extraction

## Context

Relation Extraction (RE) has been long identified as a crucial task of Information Extraction. RE is a valuable tool in the biomedical domain because it helps transform unstructured text data into structured, actionable knowledge. RE can contribute decisively to ontology and database population, knowledge discovery, or decision support systems. Several domains are targeted with RE like biological pathways [[Ohta et al., 2013](https://aclanthology.org/W13-2009)], drug discovery [[Krallinger et al., 2021](https://zenodo.org/records/4955411)], and biodiversity monitoring [[Bossy et al., 2019](https://aclanthology.org/D19-5719/)].

State of the art RE architectures are based on LLMs, especially BERT. For instance the most widely used architecture consists in formulating RE as a classification of _relation statements_, that is sentences where argument entity boundaries are marked with dedicated specific tokens [[Zhou & Chen, 2022](https://aclanthology.org/2022.aacl-short.21/)]. This method gained popularity because it is flexible, easy to implement, and yields performances close to the state of the art.

RE architectures assume the availability of gold entities; they are trained on datasets that provide entities which are potential arguments of the target relations. However, in a production setting, systems extract relations from unlabelled texts. Thus the RE model is applied on candidates generated from pairs of arguments predicted previously by a Named Entity Recognition (NER) model. Consequently RE performance reflects both the inherent performance of the RE model and of the preceding NER model. For instance a False Negative (FN) of the NER will directly result in RE False Negatives; also a False Positive (FP) of the NER model will result in additional relation candidates and thus in potential False Positives. Finally, we hypothesize that entity boundary errors might confuse the RE model.


### Objectives

This project proposes to assess the contribution of NER performance in the subsequent RE performance, and then to experiment strategies to mitigate the impact of NER errors on RE performance. We believe that simple transformations of reference datasets that embrace predicted Named Entities are able to significantly improve end-to-end RE.


### Expected results



* A detailed assessment of the impact of NER performance on RE performance.
* Insights of the impact of NER performance for different types of Named Entities or relations.
* Experimental results on strategies to mitigate this impact.
* A written communication with the obtained results.
* Positive results will be transferred to the [Omnicrobe](https://omnicrobe.migale.inrae.fr/) workflow [[Dérozier et al., 2023](https://doi.org/10.1371/journal.pone.0272473)], an integrative database on microbe biodiversity.


## Mat&Meth


### Datasets

We propose to work on RE datasets for which NE predictions are available. We will focus on the Bacteria Biotope dataset [[Bossy et al., 2019](https://aclanthology.org/D19-5719/)] that comprises a RE task as well as an end-to-end NER and RE task. Furthermore, we will provide several sets of Named Entities predictions on this dataset:



* predictions from the Omnicrobe workflow;
* predictions from the best performing participants at the BioNLP-OST 2019 challenge.

We intend to share the reference dataset, as well as the predictions on the PubAnnotation repository. On the suggestion of fellow BLAH8 participants, we may work on other datasets provided that there are:



* a reference dataset for the RE task;
* an evaluation service for the end-to-end RE task, preferably the evaluation service provides detailed errors analysis (individual FP and FN, as well as boundary inaccuracies);
* NER predictions on this dataset;
* shared on PubAnnotation to reduce the data acquisition and formatting workload.


### RE Models

We will work with the [RE-BERT](https://forgemia.inra.fr/bibliome/re-bert) software [[Tang et al., 2021](https://arxiv.org/abs/2112.02955)] based on the entity marking method. RE-BERT allows to finetune a BERT model for RE. RE-BERT also allows to select the base language model (BERT, BioBERT, SciBERT, etc.)


## Work plan


### NER impact assessment

The first step of this project is to assess the impact of NER errors on the RE performance. The strategy consists in applying a RE model on an end-to-end task using predicted Named Entities, then analyzing the detailed error reporting of the evaluation.

For each dataset we should be able to dispatch the RE errors (FP and FN) according to NER errors. We will quantify how many relation False Positives reference FP entities, entities with inaccurate boundaries, or perfect entities. Conversely we will quantify how many relations were missed because of entity False Negatives or inaccurate boundaries. This experiment will provide us insights on the contribution of NER errors, especially FP and FN, to RE performance.

A second experiment aims at assessing the impact of boundary accuracy on RE performance. We intend to evaluate RE models on a test set in which entity boundaries are randomly noised following the methodology described in [[Shen et al., 2023](https://aclanthology.org/2023.acl-long.215/)]. The performance of the RE model at different noise levels will give us a picture of the contribution of boundary accuracy on RE.

The results obtained by both experiments will outline the contribution of different types of NER errors to RE performance, and guide us to the most efficient mitigation strategies.


### Mitigation strategies

We designed three strategies for reducing the impact of NER performance on RE. We will conduct part of these strategies depending on our assessment. Also different datasets may exhibit specificities that call for specific strategies. Participants to the project might also suggest alternate strategies.


#### Training on predicted Named Entities

This strategy consists in mapping reference relations unto predicted Named Entities in the training set. In this way we construct a training set where relation arguments are closer to what the RE model might expect from the NER model. One decisive advantage expected from this strategy is that candidate relations referencing FP Named Entities are exposed as negative relation examples.


#### Simplify boundaries expectations

This strategy consists in removing variations in boundaries between reference and predicted entities by reducing entity boundaries to a single token (first, last, or syntactic head) both in reference entities of the training set and in predicted entities in the test set. We expect in this way to remove the effect of inaccurate boundaries.


#### Joint learning

There are several proposed architectures for joint learning of an end-to-end NER and RE model [[Li et al., 2017](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-017-1609-9)]. We would employ this strategy as a last resort because it is the costlier to implement, does not exploit existing NER models, computationally intensive, uncertain performance gain [[Taillé et al., 2020](https://aclanthology.org/2020.emnlp-main.301/)], and sometimes impose restrictions (e.g. non-overlapping entities).


## References

Robert Bossy, Louise Deléger, Estelle Chaix, Mouhamadou Ba, and Claire Nédellec. 2019. Bacteria Biotope at BioNLP Open Shared Tasks 2019. In _Proceedings of the 5th Workshop on BioNLP Open Shared Tasks_, pages 121–131, Hong Kong, China. Association for Computational Linguistics. [https://aclanthology.org/D19-5719/](https://aclanthology.org/D19-5719/)

Dérozier S, Bossy R, Deléger L, Ba M, Chaix E, Harlé O, et al. (2023) Omnicrobe, an open-access database of microbial habitats and phenotypes using a comprehensive text mining and data fusion approach. _PLoS ONE_ 18(1): e0272473. [https://doi.org/10.1371/journal.pone.0272473](https://doi.org/10.1371/journal.pone.0272473)

Krallinger, M., Rabal, O., Miranda-Escalada, A., & Valencia, A. (2021). DrugProt corpus: Biocreative VII Track 1 - Text mining drug and chemical-protein interactions (1.0) [Data set]. _Zenodo_. [https://doi.org/10.5281/zenodo.4955411](https://doi.org/10.5281/zenodo.4955411)

Li, F., Zhang, M., Fu, G. et al. A neural joint model for entity and relation extraction from biomedical text. _BMC Bioinformatics_ 18, 198 (2017). [https://doi.org/10.1186/s12859-017-1609-9](https://doi.org/10.1186/s12859-017-1609-9)

Tomoko Ohta, Sampo Pyysalo, Rafal Rak, Andrew Rowley, Hong-Woo Chun, Sung-Jae Jung, Sung-Pil Choi, Sophia Ananiadou, and Jun’ichi Tsujii. 2013. Overview of the Pathway Curation (PC) task of BioNLP Shared Task 2013. In _Proceedings of the BioNLP Shared Task 2013 Workshop_, pages 67–75, Sofia, Bulgaria. Association for Computational Linguistics. [https://aclanthology.org/W13-2009](https://aclanthology.org/W13-2009)

Yongliang Shen, Kaitao Song, Xu Tan, Dongsheng Li, Weiming Lu, and Yueting Zhuang. 2023. DiffusionNER: Boundary Diffusion for Named Entity Recognition. In _Proceedings of the 61st Annual Meeting of the Association for Computational Linguistics_ (Volume 1: Long Papers), pages 3875–3890, Toronto, Canada. Association for Computational Linguistics. [https://aclanthology.org/2023.acl-long.215/](https://aclanthology.org/2023.acl-long.215/)

Bruno Taillé, Vincent Guigue, Geoffrey Scoutheeten, and Patrick Gallinari. 2020. Let’s Stop Incorrect Comparisons in End-to-end Relation Extraction!. In _Proceedings of the 2020 Conference on Empirical Methods in Natural Language Processing (EMNLP)_, pages 3689–3701, Online. Association for Computational Linguistics. [https://aclanthology.org/2020.emnlp-main.301/](https://aclanthology.org/2020.emnlp-main.301/)

Tang, A., Deléger, L., Bossy, R., Zweigenbaum, P., & Nédellec, C. (2021). Does constituency analysis enhance domain-specific pre-trained BERT models for relation extraction?. _arXiv_ preprint arXiv:2112.02955. [https://arxiv.org/abs/2112.02955](https://arxiv.org/abs/2112.02955)

Wenxuan Zhou and Muhao Chen. 2022. An Improved Baseline for Sentence-level Relation Extraction. In _Proceedings of the 2nd Conference of the Asia-Pacific Chapter of the Association for Computational Linguistics and the 12th International Joint Conference on Natural Language Processing (Volume 2: Short Papers_), pages 161–168, Online only. Association for Computational Linguistics. [https://aclanthology.org/2022.aacl-short.21/](https://aclanthology.org/2022.aacl-short.21/)

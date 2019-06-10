# Birch OSIRRC Docker Image

[ ![Docker Build Status](https://img.shields.io/docker/cloud/build/osirrc2019/birch.svg)](https://hub.docker.com/r/osirrc2019/birch)
[ ![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3241945.svg)](https://doi.org/10.5281/zenodo.3241945)

[**Zeynep Akkalyoncu Yilmaz**](https://github.com/zeynepakkalyoncu), [**Wei Yang**](https://github.com/Victor0118), [**Haotian Zhang**](https://github.com/HTAustin) and [**Jimmy Lin**](https://github.com/lintool)

This is the docker image of our implementation of [Birch](https://github.com/castorini/birch) conforming to the [OSIRRC jig](https://github.com/osirrc/jig/) for the [Open-Source IR Replicability Challenge (OSIRRC) at SIGIR 2019](https://osirrc.github.io/osirrc2019/).
The image is available on [Docker Hub](https://hub.docker.com/r/osirrc2019/birch).

+ Supported test collections: `robust04`
+ Supported hooks: `init`, `index`, `search`

---

## Quick Start

The following `jig` command can be used to index TREC disks 4/5 for `robust04`:

```
python run.py prepare \
  --repo osirrc2019/birch \
  --tag latest \
  --collections robust04=/path/to/disk45=trectext
```

The following `jig` command can be used to perform a retrieval run as described in [Simple Applications of BERT for Document Retrieval](https://arxiv.org/abs/1903.10972):

```
python run.py search \
    --repo osirrc2019/birch \
    --tag latest \
    --collection robust04 \
    --topic topics/topics.robust04.txt \
    --qrels qrels/qrels.robust04.txt \
    --output out/birch \
    --measures map P.20 \
    --opts experiment=[experiment_name] num_folds=2 anserini_path=anserini tune_params=False
```

The parameter `experiment` can take on the values `qa_2cv`, `mb_2cv`, `qa_5cv` or `mb_5cv`, and denotes the pretraining data and cross-validation setting.
Likewise,`num_folds` should be set accordingly.
Use `tune_params=False` to directly evaluate on the collection, and `tune_params=True` to tune the hyperparameters yourself first.

The expected output for `experiment=mb_2cv` is as follows:

```
Evaluating results using trec_eval...
###
# out/birch/run.mb_2cv.cv.a
###
map                   	all	0.3241
P_20                  	all	0.4217

###
# out/birch/run.mb_2cv.cv.ab
###
map                   	all	0.3240
P_20                  	all	0.4209

# out/birch/run.mb_2cv.cv.abc
###
map                   	all	0.3244
P_20                  	all	0.4219
```

`*.a` refer to runs where only the top sentence is considered, `*.ab` top 2, and `*.abc` top 3 sentences.

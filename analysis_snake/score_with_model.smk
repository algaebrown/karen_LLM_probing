
#### ERIC KOFMAN EDIT STARTS HERE ####
# OUTPUT DIRECTORY
workdir: "/tscc/nfs/home/hsher/ps-yeolab5/karen_data/eclip_model_scores_human_30bp"
# SEQUENCE TO SCORE
input_fa = "/tscc/nfs/home/hsher/ps-yeolab5/karen_data/all_human_30bp.fa"
#### ERIC KOFMAN EDIT ENDS HERE ####

# Finding all eCLIP RBPNets
import pandas as pd
from pathlib import Path
tabledir = Path('/tscc/nfs/home/hsher/ps-yeolab5/ENCODE_paper_tables/')
metrics=pd.read_csv(tabledir/'model_performance.csv')
selected_models = metrics.loc[metrics['selected'], 'Experiment'].sort_values().tolist()

model_dir = Path('/tscc/nfs/home/hsher/ps-yeolab5/rbpnet_models')
models = model_dir.glob('*')
#  cp -R /tscc/nfs/home/hsher/scratch/ENCO*/output/ml/rbpnet_model/* ~/ps-yeolab5/rbpnet_models
model_dict = {}
for f in models:
    model_dict[f.name] = f
print(models)
# CODE STOLEN FROM ADAM KILE
RBPNET_PATH="/tscc/nfs/home/hsher/projects/RBPNet/"
# https://github.com/algaebrown/RBPNet

"""
# HOW TO RUN
conda activate snakemake738
module load singularitypro
snakemake -s score_with_model.smk \
    --profile /tscc/nfs/home/hsher/projects/skipper/profiles/tscc2_gpu \
    -n
"""

rule all:
    input:
        expand("output/{model_name}.score.csv",
            model_name = selected_models
                    ),
rule score_fa:
    input:
        fa = input_fa
    output:
        score="output/{model_name}.score.csv",
    threads: 1
    params:
        error_file = "stderr/score_fa.{model_name}",
        out_file = "stdout/score_fa.{model_name}",
        run_time = "02:00:00",
        cores = 1,
        memory = 80000,
        model_path = lambda wildcards: model_dict[wildcards.model_name]
    container: 
        "/tscc/nfs/home/bay001/eugene-tools_0.1.2.sif"
    shell:
        """
        export NUMBA_CACHE_DIR=/tscc/lustre/ddn/scratch/${{USER}} # TODO: HARCODED IS BAD
        export MPLCONFIGDIR=/tscc/lustre/ddn/scratch/${{USER}}
        if [ -s {input.fa} ]; then
            python {RBPNET_PATH}/score_fa_nomask.py \
                {params.model_path} \
                {input.fa} \
                {output.score} \
                /tscc/lustre/ddn/scratch/${{USER}}
        else
            touch {output.score}
        fi
        """
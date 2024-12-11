# Understanding what RBP motifs are in Karen's occlusion sequences

## To run on TSCC
environment is in `conda_env` folder. you should be able to recreate my conda environment with `-f` [ref](https://docs.conda.io/projects/conda/en/latest/commands/env/create.html). Only the GSEA notebooks need the GSEA environment, all the other ones are run with the `my_metadensity` environment.

## what each notebook does
The number suggest the orders of running notebooks. But to plot, you don't have to run them all cause intermediate files are saved on TSCC already.

- 0_join_data: joining the annotation files with occlusion score
- 1_exploratory_analysis: looking at very basic things such as GC content
- 2_make_fasta: generate .fasta files for HOMER and neural network to score

== Motif enrichment analysis ==
- 3_score_known_motif: make a .homer file from RBNS and SELEX motifs, and it contains a command to run homer.
- 3_analyze_known_motif: use chi-square and fisher exact test to find enrichment of motifs

== RBPNet score analysis ==

- to get RBPNet prediction score, check out `analysis_snake` folder. This snakemake script scores a given fasta file with all eCLIP trained RBPNet models with good enough quality.
- 4_check_RBPNet_scores: just to visualize the sequence with high RBPNet score and make sure they are similar to what we know of
- 5_analyze_RBPNet_scores: Use Mann whiteney test to see if certain category is higher than the middle category
- 6_look_at_MS: exploring MS and synGo. not important

== plotting and summarization ==
- 7_plotting: plot the volcano, explore covariates, make output to generate STRING network
- 8_GSEA: runs GSEA on RBPs ranked by either motif enrichment analysis or RBPNet score analysis

# settings
- `plot_params.py.` sets where files (csvs) and figures are saved



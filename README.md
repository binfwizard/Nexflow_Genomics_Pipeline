# 🧬 Genome Assembly and Annotation Pipeline 

A Nextflow pipeline for downloading, cleaning, assembling, and annotating raw paired-end Illumina reads. This workflow is optimized for bacterial genome annotation with Prokka.

## 📂 Test Data

This pipeline comes with a small sample dataset for testing:
- **Sample**: `SRR2584863`, an *E. coli* isolate often used in tutorials 
- **Data Source**: [NCBI SRA](https://www.ncbi.nlm.nih.gov/sra/SRR2584863)

## 🚀 Pipeline Features

- 📥 Auto-download reads from SRA (specified in run command)
- 🧼 Quality filtering with `fastp`
- 🧬 Assembly with `SPAdes`
- 🧬 Annotation with `Prokka`
- 📊 Sequence length filtering with `SeqKit`


## 🛠️ Software Requirements

To run this pipeline, install:

- **Nextflow**: `v24.10.5`
- **Conda**: `25.1.1` 
- **Operating System**: macOS (tested on macOS 14 Sonoma)
- **Architecture**: x86_64

## 🏃‍♀️Running the Pipeline 
First, clone the git repository with the following command:

```bash
git clone 
First, create the necessary Conda environment:

```bash
conda create -n nf -c bioconda nextflow=24.10.5 -y
conda activate nf


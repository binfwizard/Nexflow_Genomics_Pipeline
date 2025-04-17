# 🧬 Genome Assembly and Annotation Pipeline 

A Nextflow pipeline for downloading, cleaning, assembling, and annotating raw paired-end Illumina reads. This workflow is optimized for bacterial genome annotation with Prokka.

---

## 📂 Test Data

This pipeline comes with a sample SRA dataset for testing:
- **Sample**: `SRR2589044`
- **Data Source**: [NCBI SRA](https://www.ncbi.nlm.nih.gov/sra/SRR2589044)

No need to manually download it — the pipeline will automatically fetch the dataset during execution. ✅

---

## 🚀 Pipeline Features

- 📥 Auto-download reads from SRA (specified in run command)
- 🧼 Quality filtering with `fastp`
- 🧬 Assembly with `SPAdes`
- 🧬 Annotation with `Prokka`
- 📊 Sequence length filtering with `SeqKit`


## 🛠️ Software Requirements

To run this pipeline, install:

- **Nextflow**: `v24.10.5`
- **Conda**: `>=4.8.0` (tested with Conda 4.12.0)
- **Operating System**: macOS (tested on macOS 14 Sonoma)
- **Architecture**: x86_64

## Running the Pipeline 
And create the necessary Conda environment like this:

```bash
conda create -n nf -c bioconda nextflow=24.10.5 -y
conda activate nf


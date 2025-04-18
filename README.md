# 🧬 Genome Assembly and Annotation Pipeline 

A Nextflow pipeline for downloading, cleaning, assembling, and annotating raw paired-end Illumina reads. This workflow is optimized for bacterial genome annotation with Prokka.

This pipeline was created for the "Workflow" exercise for **BIOL7210**.

## 📂 Test Data

This pipeline comes with a small sample dataset (located in Nextflow_Genomics_Pipeline/data) for testing:
- **Sample**: `SRR2584863`, an *E. coli* isolate often used in tutorials 
- **Data Source**: [NCBI SRA](https://www.ncbi.nlm.nih.gov/sra/SRR2584863)

Test data was generated using the following commands:

```bash
gunzip -c SRR2584863_1.fastq.gz | head -n 40000 | gzip > test_R1.fastq.gz
gunzip -c SRR2584863_2.fastq.gz | head -n 40000 | gzip > test_R2.fastq.gz
```

## 🚀 Pipeline Features

- 📥 Auto-download reads from SRA or use paired datasets in the format *_R{1,2}.fastq.gz located in the "/data" folder
- 🧼 Quality filtering with `fastp`
- 🧬 Assembly with `SPAdes`
- 🧬 Annotation with `Prokka`
- 📊 Sequence length filtering with `SeqKit`


## 🛠️ Software Requirements

To run this pipeline, install:

- **Nextflow**: `v24.10.5`
- **Conda**: `v24.3.0` ⚠️ Due to a recent bug in newer Conda versions (specifically `v25.x`), a downgraded, more stable version of Conda will be used for this pipeline
- **Operating System**: macOS (tested on macOS 14 Sonoma)
- **Architecture**: x86_64

## 🏃‍♀️💨 Running the Pipeline 
First, clone the git repository with the following command:

```bash
git clone https://github.com/binfwizard/Nexflow_Genomics_Pipeline.git
cd Nexflow_Genomics_Pipeline
```
Next, create a Conda environment (using Conda 24.3.0) and install Nextflow:

```bash
conda create -n nf -c bioconda nextflow -y
conda activate nf
conda install conda=24.3.0
```

Finally, run the pipeline on the test dataset in one command:

```bash
nextflow run nextflow_pipeline.nf -profile conda --threads 8
```

Alternatively, the pipeline can automatically download and process SRA reads using the `--srr_id` flag: 

```bash
nextflow run nextflow_pipeline.nf -profile conda --threads 8 --srr_id "SRR2584863"
```

## 🔗 Dependencies
All of the following tools will be automatically installed via Bioconda:
- **fastp**: `v0.23.4`
- **SPAdes**: `v3.15.5`
- **SeqKit**: `v2.6.1`
- **Prokka**: `v1.14.6`

## 📝 Output Structure 

```
Pipeline Output Structure:
├── results/
│   ├── fastp/
│   │   ├── cleaned_1.fastq.gz
│   │   ├── cleaned_2.fastq.gz
│   │   ├── fastp_report.html
│   │   ├── fastp_report.json
│   │   └── fastp.log
│   ├── spades/
│   │   ├── contigs.fasta
│   │   └── spades.log
│   ├── seqkit/
│   │   ├── filtered.fastq.gz
│   │   └── seqkit.log
│   └── prokka/
│       ├── annotation.gff
│       └── prokka.log
```


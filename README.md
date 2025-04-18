# 🧬 Genome Assembly and Annotation Pipeline 

A Nextflow pipeline for downloading, cleaning, assembling, and annotating raw paired-end Illumina reads. This workflow is optimized for bacterial genome annotation with Prokka.

This pipeline was created for the "Workflow" exercise in **BIOL7210**.

## 📂 Test Data

This pipeline comes with a small sample dataset (located in Nextflow_Genomics_Pipeline/data) for testing:
- **Sample**: `SRR2584863`, an *E. coli* isolate often used in tutorials 
- **Data Source**: [NCBI SRA](https://www.ncbi.nlm.nih.gov/sra/SRR2584863)

## 🚀 Pipeline Features

- 📥 Auto-download reads from SRA (can be specified in run command)
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

## 🏃‍♀️💨 Running the Pipeline 
First, clone the git repository with the following command:

```bash
git clone https://github.com/binfwizard/Nexflow_Genomics_Pipeline.git
cd Nextflow_Genomics_Pipeline
```
Next, create a Conda environment and install Nextflow:

```bash
conda create -n nf -c bioconda nextflow -y
conda activate nf
```

Finally, run the pipeline on the test dataset in one command:

```bash
nextflow run nextflow_pipeline.nf -profile conda --threads 8
```

Alternatively, the pipeline can automatically download SRA reads using the `--srr_id` flag: 

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


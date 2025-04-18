// Define parameters
params.srr_id = null
params.reads = "data/*_R{1,2}.fastq.gz"
params.outdir = "results"
params.threads = 8

// Outline workflow
workflow {
    main:
    if (params.srr_id) {
        PREFETCH(params.srr_id)
        FASTP(PREFETCH.out)
    } else {
        reads_ch = Channel.fromFilePairs(params.reads, flat: true)
        FASTP(reads_ch)
    }

    SPADES(FASTP.out)
    SEQKIT(FASTP.out)
    SPADES.out.map { id, contigs, _ -> tuple(id, contigs) } | PROKKA
}

// Prefetch data from SRA
process PREFETCH {
    tag "${srr_id}"
    
    input:
    val srr_id
    
    output:
    tuple val(srr_id), path("${srr_id}_1.fastq.gz"), path("${srr_id}_2.fastq.gz")
    
    script:
    """
    prefix=\$(echo ${srr_id} | cut -c1-6)
    curl -sS "ftp://ftp.sra.ebi.ac.uk/vol1/fastq/\$prefix/00${srr_id[-1]}/${srr_id}/${srr_id}_1.fastq.gz" -o ${srr_id}_1.fastq.gz
    curl -sS "ftp://ftp.sra.ebi.ac.uk/vol1/fastq/\$prefix/00${srr_id[-1]}/${srr_id}/${srr_id}_2.fastq.gz" -o ${srr_id}_2.fastq.gz
    """
}

// Run fastp for quality control
process FASTP {
    conda 'bioconda::fastp=0.23.4'
    tag "$sample_id"
    publishDir "${params.outdir}/fastp", mode: 'copy'

    input:
    tuple val(sample_id), path(read1), path(read2)

    output:
    tuple val(sample_id),
          path("cleaned_1.fastq.gz"),
          path("cleaned_2.fastq.gz"),
          path("fastp.log"),
          path("fastp_report.html"),
          path("fastp_report.json")

    script:
    """
    fastp -i ${read1} -I ${read2} \
        -o cleaned_1.fastq.gz \
        -O cleaned_2.fastq.gz \
        --html fastp_report.html \
        --json fastp_report.json \
        > fastp.log 2>&1
    """
}

// Run SPAdes for assembly
process SPADES {
    conda 'bioconda::spades=3.15.5'
    publishDir "${params.outdir}/spades", mode: 'copy'

    input:
    tuple val(id), path(read1), path(read2), path(fastp_log), path(html), path(json)

    output:
    tuple val(id), path("contigs.fasta"), path("spades.log")

    script:
    """
    spades.py -1 ${read1} -2 ${read2} \
        -o spades_out \
        --threads ${params.threads} \
        --phred-offset 33 \
        > spades.log 2>&1

    cp spades_out/contigs.fasta contigs.fasta
    """
}

// Run seqkit for filtering
process SEQKIT {
    conda 'bioconda::seqkit=2.6.1'
    publishDir "${params.outdir}/seqkit", mode: 'copy'

    input:
    tuple val(sample), path(read1), path(read2), path(fastp_log), path(html), path(json)

    output:
    tuple val(sample), path("filtered.fastq.gz"), path("seqkit.log")

    script:
    """
    seqkit seq -m 1000 -M 2000 -g \
        -o filtered.fastq.gz \
        ${read1} \
        > seqkit.log 2>&1
    """
}

// Run Prokka for annotation
process PROKKA {
    conda 'bioconda::prokka=1.14.6'
    publishDir "${params.outdir}/prokka", mode: 'copy'

    input:
    tuple val(id), path(contigs)

    output:
    tuple path("annotation.gff"), path("prokka.log")

    script:
    """
    prokka --outdir prokka_${id} \
        --prefix ${id} \
        ${contigs} \
        > prokka.log 2>&1

    cp prokka_${id}/${id}.gff annotation.gff
    """
}





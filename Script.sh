#!/bin/bash

#Set up  of packages and tools

module load sra-toolkit
module load seqtk
module load apptainer/1.4.5
module load minimap2/2.26
module load samtools/1.18
module load bcftools/1.22

#Section 1: Assembly of genome and variant calling -------------------------------------------

#Step1: Download of raw reads produced via Oxford Nanopore Sequencing

wget https://sra-pub-run-odp.s3.amazonaws.com/sra/SRR32410565/SRR32410565

#Step 2: Convert the raw reads into a FASTQ format

fasterq-dump SRR32410565

#Step3: Perform quality check controls over the reads in FASTQ format

seqtk fqchk SRR32410565.fastq > SRR32410565.fqchk.txt #The visualization of this output allowed to determine that the reads had to be filtered to remove those  with a Phred quality of below 10.

seqtk seq -q10 SRR32410565.fastq > SRR32410565.q10.fastq #This filtered output was used to assemble the genome

#Step4: Assembly of genome

mkdir flye_out

apptainer exec docker://staphb/flye flye \
	--nano-hq SRR32410565.q10.fastq \
	--out-dir flye_out \
	--threads 16

#Step5: Download of reference genome from NCBI

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/006/945/GCF_000006945.2_ASM694v2/GCF_000006945.2_ASM694v2_genomic.fna.gz
gunzip GCF_000006945.2_ASM694v2_genomic.fna.gz

#Step6: Alignment of reference genome to assembled genome

minimap2 -ax asm5 \
  GCF_000006945.2_ASM694v2_genomic.fna \
  flye_out/assembly.fasta  \
  > flye_reference.sam #As this output is in .SAM format, it needs to be converted into a BAM format

#Step7: Conversion of "flye_reference.sam" file from a .SAM to a .BAM format

samtools view -bS flye_reference.sam -o flye_reference.bam

samtools sort flye_reference.bam -o align.sorted.bam

samtools index align.sorted.bam

#Step8: Variant calling

bcftools mpileup -f GCF_000006945.2_ASM694v2_genomic.fna align.sorted.bam | bcftools call -mv -Oz -o difference_flye_ref.vcf.gz #This output was visualized using the zcat command to ensure its correct format

#Step 9: Download of annotated genome

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/006/945/GCF_000006945.2_ASM694v2/GCF_000006945.2_ASM694v2_genomic.gff.gz
gunzip GCF_000006945.2_ASM694v2_genomic.gff.gz

#Section 2: Visualization of assembled genome -------------------------------------------

#Step10: Alignment of FASTQ reads to assembled genome

minimap2 -ax asm5 flye_out/assembly.fasta SRR32410565.q10.fastq > align_to_assembly.sam

#Step11: Conversion of "align_to_assembly.sam" file from a .SAM to a .BAM format

samtools view -Sb align_to_assembly.sam > align_to_assembly.bam

samtools sort align_to_assembly.bam -o align_to_assembly.sorted.bam

samtools index align_to_assembly.sorted.bam

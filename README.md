**Introduction**

This report has two objectives. Firstly, to assemble the genome of Salmonella enterica from raw reads provided in FASTQ format. The second objective is to assess the accuracy of the consensus genome by comparing it to a reference genome downloaded from NCBI, allowing the quantification of similarities and differences. As such, the goal is to determine the strengths and challenges of bioinformatics methods to assemble and align bacterial genomes.

Salmonella enterica is of particular interest because it contains a high diversity of antimicrobial resistance genes (Li et al., 2021). Among isolates obtained from commercial meat products, researchers have found 33 different serotypes (Li et al., 2021), demonstrating an abundant phylogenetic diversity that contributes to the variety of resistance genes observed. Regarding sequencing technologies, methods that rely on short reads often produce low-quality genomes with high numbers of contigs (Smits, 2019). As such, newer approaches like the Oxford Nanopore sequencer reduce the number of contigs produced (Lu et al., 2016).

Several methods exist to assemble a genome and to align it to a reference genome. Regarding the former, the flye package has a lower error rate than other methods, but it uses a high amount of RAM (Wick and Holt, 2020). Compared to it, Canu has a substantially longer runtime and performs poorly with circular DNA molecules while producing relatively reliable assemblies (Wick and Holt, 2020). Regarding variant calling as a comparison method, incorrect read alignment to the reference genome may lead to amplification biases (Zverinova and Guryev, 2022). However, its usage on long reads is significantly useful to detect structural differences and to differentiate between tandem and dispersed copy-number variants (Zverinova and Guryev, 2022). The Whole Genome Assembly (WHA) method also exhibits trade-offs. While it is capable of managing a large volume of genomic data in a time-efficient way, its accuracy is often limited (Saada et al., 2024). As such, flye and variant calling will be used as part of the methodology.

**Methods**

**Results**

**Discussion**

**References**

**Structure of Repository**

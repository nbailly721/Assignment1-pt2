**Introduction**

This report has two objectives. Firstly, to assemble the genome of Salmonella enterica from raw reads provided in FASTQ format. The second objective is to assess the accuracy of the consensus genome by comparing it to a reference genome downloaded from NCBI, allowing the quantification of similarities and differences. As such, the goal is to determine the strengths and challenges of bioinformatics methods to assemble and align bacterial genomes.

Salmonella enterica is of particular interest because it contains a high diversity of antimicrobial resistance genes (Li et al., 2021). Among isolates obtained from commercial meat products, researchers have found 33 different serotypes (Li et al., 2021), demonstrating an abundant phylogenetic diversity that contributes to the variety of resistance genes observed. Regarding sequencing technologies, methods that rely on short reads often produce low-quality genomes with high numbers of contigs (Smits, 2019). As such, newer approaches like the Oxford Nanopore sequencer reduce the number of contigs produced (Lu et al., 2016).

Several methods exist to assemble a genome and to align it to a reference genome. Regarding the former, the flye package has a lower error rate than other methods, but it uses a high amount of RAM (Wick and Holt, 2020). Compared to it, Canu has a substantially longer runtime and performs poorly with circular DNA molecules while producing relatively reliable assemblies (Wick and Holt, 2020). Regarding variant calling as a comparison method, incorrect read alignment to the reference genome may lead to amplification biases (Zverinova and Guryev, 2022). However, its usage on long reads is significantly useful to detect structural differences and to differentiate between tandem and dispersed copy-number variants (Zverinova and Guryev, 2022). The Whole Genome Assembly (WHA) method also exhibits trade-offs. While it is capable of managing a large volume of genomic data in a time-efficient way, its accuracy is often limited (Saada et al., 2024). As such, the flye package and variant calling will be used as part of the methodology.

​​In terms of my overall approach, I will use the flye package to assemble the genome, minimap2 to align it to the reference genome, SAMtools (view, sort, index options) to process the alignment, and IGV to visualize it. The latter three have pros and cons: Even though minimap2 is uniquely capable of performing read overlapping, the whole downstream analysis depends on its metrics being correctly set (Wick and Holt, 2020). SAMtools efficiently processes large BAM files, but indexing them is memory-intensive (Weeks and Luecke, 2017). Likewise, even though the Integrative Genomics Viewer (IGV) aids in the interpretation of the alignments, it may be hard to navigate when using large genomes. Regarding the general parameters, using 32 cores throughout all the analysis will reduce the computational time, but will limit reproducibility by requiring access to external servers (like Canada Compute). Furthermore, the use of - -nano-hq will allow the assembly of relatively accurate long sequences while still requiring previous polishing steps.


**Methods**

All the code was performed in the Narval cluster of the Digital Research Alliance of Canada using Bash. The starting raw reads of S. enterica, which were produced via Oxford Nanopore Sequencing, were downloaded (via wget) and converted into a FASTQ format using the sra-toolkit (fasterq-dump) (National Center for Biotechnology Information). The seqtk package (v. 1.4) was then used to produce a summary of the FASTQ file and to remove reads with a Phred quality of below 10 (Heng Li, 2012). Subsequently, the genome was assembled using the flye (v. 2.9.6) package (Kolmogorov et al., 2016). The - - nano-hq option was used because the raw reads were filtered for quality. After the assembly stage, the reference genome was downloaded from NCBI and aligned to the assembled one using minimap2 (v. 1.18) using the options -ax asm5 (Dana-Farber Cancer Institute, 2018). 

SAMtools (v 1.18) was then used to convert the alignment file to a BAM format, view it (-bS option), sort it, and index it (Thomas et al., 2025, Genome Research Ltd. 2025). Thereafter, the bcftools (v. 1.22) package was employed (mpileup -f options) to call variants by comparing the aligned reads with the reference genome and producing an output VCF.gz file (SAMtools team). This compressed file was visualized preliminarily in the terminal using the zcat command to ensure it had to correct format.  The VCF.gz file containing the variant calling output and the associated annotated file (.gff format) were visualized using the Integrative Genomics Viewer (IGV) (Robinson and Zemo, 2017). The annotated and reference genomes were downloaded from NCBI. To locate the specific links, please refer to the script present in the repository called ‘Script.sh’.

In order to map the genome assembled from the raw reads, a separate procedure was carried out. Specifically, the assembled genome (in .fasta format) was aligned to the quality-trimmed Nanopore reads, and the resulting alignment was converted to BAM format, sorted, and indexed using SAMtools. Then, the output was visualized in the IGV. These steps used the same options as those employed for the reference genome alignment and visualization. The graphical fragment assembly file, which was also produced during the assembly, was visualized using the Bandage software (v. 0.8.1). In the latter, the depth and length of the nodes were displayed (Wick et al., 2015).

The visualized differences between the reference and assembled genomes were analyzed. As Single Nucleotide Polymorphisms (SNPs) were found in several genes, only two genes were selected for further studies. This selection was based on whether or not those SNPs showed a nucleotide transversion or transition. 


**Results**
<p align="center">
  <img src="https://github.com/user-attachments/assets/e71f83cf-44ce-4a44-a77a-771ecee8c43c" width="700" />
  <br>
  <em>Figure 1.0: Visualization of the differences between the reference and assembled genome (Salmonella enterica) using variant calling. Specifically, there is a transversion mutation at the sopA gene (Adenine to Cytosine). While the 'A' belongs to the reference genome, the 'C' is part of the assembled genome.
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/8df316f5-7ab6-430d-9c19-54528318f861" width="700" />
    <br>
  <em>Figure 1.1: Visualization of the differences between the reference and assembled genome (Salmonella enterica) using variant calling. Specifically, there is a transition mutation at the pduk gene (Thymine to Cytosine). While the 'T' belongs to the reference genome, the 'C' is part of the assembled genome.
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/5146badb-f3f9-4d23-a2e8-b1f1e6416b74" width="700" />
    <br>
  <em>Figure 2.0: Visualization of the assembled genome of Salmonella enterica using the Bandage software. It shows the depth (x) and length (bp) of the nodes.
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/de1a5636-8916-4faa-8d0c-e35cace227c0" width="700" />
  <br />
  <em>Figure 3.0: Visualization of the assembled genome of <i>Salmonella enterica</i> using the Interactive Genome Viewer. It shows a higher coverage than contigs 3 and 4.</em>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/bf154184-e891-4ccc-a855-411259c80ca0" width="700" />
  <br />
  <em>Figure 3.1: Visualization of the assembled genome of <i>Salmonella enterica</i> using the Interactive Genome Viewer. It shows a lower coverage than contig 2.</em>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/7405e679-49b3-4694-92b7-a791b5237b41" width="700" />
  <br />
  <em>Figure 3.2: Visualization of the assembled genome of <i>Salmonella enterica</i> using the Interactive Genome Viewer. It shows a lower coverage than contig 2.</em>
</p>


  **Discussion**

  When comparing the reference and assembled genomes, 1060 SNPs were found in total. For example, Figure 1.0 shows a transversion (Adenine to Cytosine), and Figure 1.1 shows a transition (Thymine to Cytosine), where the first base represents the reference genome and the second the assembled genome. These differences may have a key effect on the survival and infectious potential of S. enterica. For instance, a single SNP in the promoter region of the ptgE gene can enhance its resistance to human serum (Hammarlöf et al., 2018), which contains antibiotic properties. However, our examination of the annotated genome suggested that the coding regions were largely conserved with respect to small insertions or deletions. This is consistent with the findings of Pang et al. (2013), which suggested that in six S. enterica strains, there were only 7 indels and up to 922 SNPs. As these indels were associated with the inactivation of virulence-related genes (Pang et al., 2013), our findings suggest that the reference and assembled genomes are largely similar in these regions. As such, major differences in virulence between the analyzed genomes are unlikely.

Regarding the assembled genome, three contigs were visualized. As seen in Figures 3.0 to 3.2, contig 2 has a relatively higher coverage than contigs 3 and 4. Such differences in coverage may reflect that contig 2 represents plasmid DNA, while the other contigs likely represent chromosomal DNA. This is supported by Antipov et al. (2016), who demonstrated that plasmids and chromosomes can have different read coverages arising from distinct copy numbers. It is, however, important to note that minor technical biases during the flye-based assembly may have affected coverage. This may require further investigation.

Regarding S. enterica gene functionality, several genes with SNPs in their coding regions were found. For instance, the pduk gene, which is a protein-coding gene of the Propanediol Utilization Operon, is present in the reference chromosome NC_003197.2. This specific gene plays a key role in the formation of polyhedral bodies in bacteria, which are necessary for the degradation of toxic propanediol (Bobik et al.,1999). As such, missense mutations arising from SNPs can lead to the production of truncated or ineffective proteins with an impaired ability to degrade propanediol and hence cause toxicity within the bacteria. In other words, a hypothetical S. enterica containing our assembled genome may suffer from higher levels of intracellular toxicity.

A similar scenario is seen with the sopA gene, which is also found in the chromosome NC_003197.2. It codes for the sopA effector protein, which forms part of the Spa type III secretion system, a key infectious pathway of some Salmonella species. Specifically, this protein is translocated into the eukaryotic cells of hosts to induce fluid secretion and inflammation, promoting enteritis (Wood et al., 2001). Consequently, missense mutations in the S. enterica containing the assembled genome may lead to the transcription of ineffective enzymes. This can potentially reduce the infectious potential of the bacteria and its ability to induce host responses.


  **References**

1.Antipov, D. et al. (2016) Plasmidspades: Assembling plasmids from whole genome sequencing data. doi:10.1101/048942. 
2.Bobik, T.A. et al. (1999) ‘The propanediol utilization (pdu) operon of salmonella enterica serovar typhimurium LT2 includes genes necessary for formation of polyhedral organelles involved in coenzyme B12-dependent 1,2-propanediol degradation’, Journal of Bacteriology, 181(19), pp. 5967–5975. doi:10.1128/jb.181.19.5967-5975.1999.
3.Dana-Farber Cancer Institute (2018) Minimap2, GitHub. Available at: https://github.com/lh3/minimap2?tab=License-1-ov-file (Accessed: 17 January 2026).
4.Genome Research Ltd. (2025) Samtools, GitHub. Available at: https://github.com/samtools/samtools?tab=License-1-ov-file (Accessed: 17 January 2026).
5.Hammarlöf, D.L. et al. (2018) ‘Role of a single noncoding nucleotide in the evolution of an epidemic African clade of salmonella’, Proceedings of the National Academy of Sciences, 115(11). doi:10.1073/pnas.1714718115.
6.Kolmogorov, M. (2016) Flye, GitHub. Available at: https://github.com/mikolmogorov/Flye/tree/flye?tab=License-1-ov-file (Accessed: 17 January 2026).
7.Li, C. et al. (2021) ‘Long-read sequencing reveals evolution and acquisition of antimicrobial resistance and virulence genes in Salmonella enterica’, Frontiers in Microbiology, 12. doi:10.3389/fmicb.2021.777817.
8.Li, H. (2012) Seqtk, GitHub. Available at: https://github.com/lh3/seqtk?tab=MIT-1-ov-file (Accessed: 17 January 2026).
9.Lu, H., Giordano, F. and Ning, Z. (2016) ‘Oxford Nanopore Minion Sequencing and Genome Assembly’, Genomics, Proteomics & Bioinformatics, 14(5), pp. 265–279. doi:10.1016/j.gpb.2016.05.004.
10.National Center for Biotechnology Information. HowTo: fasterq dump, Github. Available at https://github.com/ncbi/sra-tools/wiki/HowTo:-fasterq-dump (Accessed: 2 February 2026).
11.Pang, S. et al. (2013) ‘Genomic diversity and adaptation of salmonella enterica serovar typhimurium from analysis of six genomes of different phage types’, BMC Genomics, 14(1). doi:10.1186/1471-2164-14-718. 
12.Robinson, P. and Zemo, J. T. (2017) ‘Integrative genomics viewer (IGV): Visualizing alignments and variants’, Computational Exome and Genome Analysis, pp. 233–245. doi:10.1201/9781315154770-17.
13.Saada, B. et al. (2024) ‘Whole genome alignment: Methods, challenges, and future directions’, Applied sciences. doi:10.20944/preprints202402.1197.v1.
14.SAMtools Team. BCFtools HOW TO. Available at: https://samtools.github.io/bcftools/howtos/index.html (Accessed: 17 January 2026).
15.Smits, T.H. (2019) ‘The importance of genome sequence quality to microbial comparative genomics’, BMC Genomics, 20(1). doi:10.1186/s12864-019-6014-5.
16.Thomas, C. et al. (2025) ‘Accurately assembling nanopore sequencing data of highly pathogenic bacteria’, BMC Genomics, 26(1). doi:10.1186/s12864-025-11793-6.
17.Weeks, N.T. and Luecke, G.R. (2017) ‘Optimization of SAMtools sorting using openmp tasks’, Cluster Computing, 20(3), pp. 1869–1880. doi:10.1007/s10586-017-0874-8.
18.Wick, R.R. et al. (2015) ‘Bandage: Interactive visualization of de novo                    genome assemblies’, Bioinformatics, 31(20), pp. 3350–3352. doi:10.1093/bioinformatics/btv383. 
19.Wick, R.R. and Holt, K.E. (2020) ‘Benchmarking of long-read assemblers for prokaryote whole genome sequencing’, F1000Research, 8, p. 2138. doi:10.12688/f1000research.21782.3.
20.Wood, M.W. et al. (2001) ‘The secreted effector protein of Salmonella Dublin, SOPA, is translocated into eukaryotic cells and influences the induction of enteritis’, Cellular Microbiology, 2(4), pp. 293–303. doi:10.1046/j.1462-5822.2000.00054.x.
21.Zverinova, S. and Guryev, V. (2022) ‘Variant calling: Considerations, practices, and developments’, Human Mutation, 43(8), pp. 976–985. doi:10.1002/humu.24311.


  **Repository structure and files**

This repository contains the following:

1)'Script.sh': Bash script used to perform the variant calling between the reference genome and the assembled genome.

2)'variant_calling' folder: It contains the assembled genome (assembly.fasta), the Variant Call Format file (difference_flye_ref.vcf.gz), the sorted .BAM file containing the alignment between the reference and assembled genome (align.sorted.bam) and the associated .BAM index file (align.sorted.bam.bai). It also contains the reference (GCF_000006945.2_ASM694v2_genomic.fna) and annotated (GCF_000006945.2_ASM694v2_genomic.gff) genomes used.

3)'assembly_visualization' folder: It contains the Graphical Fragment Assembly file (assembly_graph.gfa) of the assembled genome.

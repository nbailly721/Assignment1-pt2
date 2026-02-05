**Introduction**

**Methods**

**Results**
<p align="center">
  <img src="https://github.com/user-attachments/assets/e71f83cf-44ce-4a44-a77a-771ecee8c43c" width="700" />
  <br>
  <em>Figure 1.0: Visualization of the differences between the reference and assembled genome (Salmonella Enterica) using variant calling. Specifically, there is a transversion mutation at the sopA gene (Adenine to Cytosine). While the 'A' belongs to the reference genome, the 'C' is part of the assembled genome.
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/8df316f5-7ab6-430d-9c19-54528318f861" width="700" />
    <br>
  <em>Figure 1.1: Visualization of the differences between the reference and assembled genome (Salmonella Enterica) using variant calling. Specifically, there is a transition mutation at the pduk gene (Thymine to Cytosine). While the 'T' belongs to the reference genome, the 'C' is part of the assembled genome.
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

  **References**

  **Repository structure and files**



**Discussion**

**References**

**Structure of Repository**

This repository contains the following:
1)'Script.sh': Bash script used to perform the variant calling between the reference genome and the assembled genome.
2)'variant_calling' folder: It contains the assembled genome (assembly.fasta), the Variant Call format (difference_flye_ref.vcf.gz), the sorted .BAM file containing the alignment between the reference and assembled genome (align.sorted.bam) and the associated .BAM file index (align.sorted.bam.bai). It also contains the reference (GCF_000006945.2_ASM694v2_genomic.fna) and annotated (GCF_000006945.2_ASM694v2_genomic.gff) genomes used.
3)'assembly_visualization' folder: It contains the Graphical Fragment Assembly (assembly_graph.gfa) of the assembled genome.

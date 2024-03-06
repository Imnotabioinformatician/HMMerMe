### Create 'GPCR' environment with the follwoing software tools installed

`conda create -y -n GPCR -c bioconda -c conda-forge python=3.11 seqkit hmmer muscle=3.8.1551 weblogo transdecoder easel diamond trimal pymsaviz`

Activating said environment

`conda activate GPCR`

### Download and utlize 'HMMerME'

In your working directory of choice

`git clone git@github.com:plantgenomicslab/HMMerMe.git`

If you have not created an SSH key, please do so:

Go into 'HMMerME' folder

`$cd HMMerME`

### Running 'HMMerME'

Main code will be in `run.py`

`run.py` takes in 2 required arguments: `--input` and `--db`

`--input` will target the `Input` directory that has your `.fasta` and `_clean.fasta` files

`--db` will target the 'Database' directory that has your '.hmm' files, called after an HMM search

`--CPU` is one of the options that utilizes a specific core. If not called, default is set to use 2 cores (4 threads)

`--visualization` is another option that calls 'weblogo' and 'pymsaviz' to visualize your data

To run the command, go into the 'HMMerME' directory as the current working directory as simply type this:

`python run.py --input Input/ --db Database/ [OPTIONS --CPU, --visualization]`

Remember, if you want a weblogo and visualized aligned sequences, run `--visualization`

`python run.py --input Input/ --db Database/ --visualization`

### Input and Output Files

Input files include

```
{Homology_domain}.hmm
{Species}.fasta
```

Output files include

```
{Species}.hmm_results
{Species}_{Homology_domain}.list
{Species}_{Homology_domain}.fasta
{Species}_{Homology_domain}_domain.bed
{Species}_{Homology_domain}_domain.fasta

{Species}_conflict.list
{Species}_conflict.fasta
{Species}_conflict_domain.bed
{Species}_conflict_domain.fasta

{Species}_counts.txt

{Species}_{Homology_domain}_muslced_domain.fa
{Species}_{Homology_domain}_muscled_trimal_domain.fa

{Species}_{Homology_domain}_muscled_combined_domain.afa
{Species}_{Homology_domain}_muscled_combined_trimal_domain.afa

{Species}_{Homology_domain}_muscled_combined_trimal_domain.pdf
{Species}_{Homology_domain}_muscled_combined_trimal_domain.png
```
## Quick explanation

Within the `Database` directory, there are `.hmm` files. These files are your HMM profile files. An HMM profile is simply a statistical algorithms that detects homology between your query and a predefined large sequence databases (Johnson et al. 2010). These HMM profile files are found in the `Database` directory. Additonally, within your `Input` directory, there are your species fasta files. Having both the fasta files and HMM profile files will allow `run.py` to find the homology sequence between your fasta files and HMM profiles. 

Lets take a look at the format for species AaegyptiLVPWY. There are exactly 28,392 genes within the AaegyptiLVPWY fasta file. In the Database folder, there are 49 HMM profile that were found from calling HMM search. `run.py` will try to find and match all possible homology between your fasta file and the HMM profile. If found, you should obtain this type of format: {Species}_{Homology_domain}. Additionally, there are a bunch of output files called after `run.py`. Let go over them in breif

The first file that outputs is the {Species}.hmm_results. After Processing each of your FASTA file against a large datbase called by HMMER, a homology results will show with an E-value of less thatn 1e-10 (Remember, lower the E-value, greater the significance that the search was not due to chance but for biological significance). Within the `.hmm_results` file, Column 1 represents the domain gene, Column 2 represents the domain name, Column 18 and 19 represents the alignment coordinate form and to respectivley. Your `.hmm_search` file is important as it will be used to model your `.list`, `.fasta`, `domain.bed`, and `domain.fasta` files. 

The `.list`, `.fasta`, `domain.bed`, and `domain.fasta` files have the formats: {Species}_{Homology_domain} where Species is your species of interest and the name of the Homologous domain group. `.list` will tel you the domain genes that is represented from the search, `.fasta`, will search domain gene sequences that are found in the the fasta files, `domain.bed` will give you a bed format that includes where the domain gene is found in coordinate format, and `domain.fasta` will print out respective subsets of domain gene sequences in fasta format form by using `domain.bed`.

From creating the `.list`, `.fasta`, `domain.bed`, and `domain.fasta` files, it will also create `conflict.list`, `conflict.fasta`, `conflict_domain.bed`, and `conflict_domain.fasta` files. To put it in simple terms, some domain genes can have the same sequences but differnt domain names. Therefore, the `conflict.list` file will represents the domain genes that have conflicing domain names, `conflict.fasta` will output the fasta sequences of that conflicting genes, `conflict_domain.bed` will give you a bed format of the conflicting domain gene in coordinate format, and `conflict.fasta` will extract subsets of conflciting gene sequences using `conflict_domain.bed`

Next is the `counts.txt`. This file will give you the total amount of Domain genes that were distinguished from your `.hmm_search` file.

The `muslced_domain.fa` files are simply aligned fasta sequences using the Muscle program version 3.8.1551 (Edgar et al 2021). Additionally, some sequences have to much of a gap, we will call trimal to remove these gaps in a file format of `muscled_trimal_domain.fa`.

The `muscled_combined_domain.afa`files combines the sequence alignments of the HMM search files in the form of `.afa` files. In turn, `run.py` will try to combine your `muscled_combined_domain.fa` and the `{Homology_domain}.afa` files in the `Database_alignment` directory if a match between the Homology name is found. the 'muscled_combined_trimal_domain.afa' simply calls trimal to remove unecessary gaps.

Finally `.pdf` and `.png` files are made. If you called `--visualziation` it will call Weblogo v3 (Crooks et al 2004) and Pymsaviz (https://pypi.org/project/pyMSAviz/) to create the `.pdf` and `.png` files respectively. Here are some visualization:

[AaegyptiLVPWY_Adipokinetic_Corazonin_muscled_combined_trimal_domain.pdf](https://github.com/plantgenomicslab/HMMerMe/files/14514243/AaegyptiLVPWY_Adipokinetic_Corazonin_muscled_combined_trimal_domain.pdf)

![AaegyptiLVPWY_Adipokinetic_Corazonin_muscled_combined_trimal_domain](https://github.com/plantgenomicslab/HMMerMe/assets/137996393/75e025cf-6219-40db-9465-78a11d80f7c4)


###### DR. YIMS ######

## GPCR identification

### Environment creation
```bash
conda create -y -n GPCR -c bioconda -c conda-forge   python=3.11 seqkit hmmer muscle=3.8.1551 weblogo transdecoder easel diamond trimal pymsaviz
conda activate GPCR

#wget https://github.com/fteufel/signalp-6.0/archive/refs/heads/main.zip -O SignalP6.zip
#unzip SignalP6.zip
#pip install signalp-6.0-main

git clone git@github.com:plantgenomicslab/HMMerMe.git
cd HMMerMe
```
### Run example
usage: run.py [-h] --input INPUT_FOLDER --db DB_FOLDER --CPU CPU [--logging]
```
 python run.py --input Input --db Database --CPU 4
```
output is `output` folder

### To DO Tasks

Within the `output` directory:
1. The `output` directory contains folders named after species. Within each species' folder, there is a file named `{Species_name}.hmm_results`.
2. Omit the first line of `{Species_name}.hmm_results` if it starts with `#`.
3. The fourth column, which lists queries like 7tm_1 and 7tm_2, will be expanded in the future.
4. Generate the following outputs:
   - A file named `{species}_{domain_name=4th_column}.list`, containing only IDs from the first column. Create a separate file for each domain name in the fourth column.
   - A file named `{species}_{domain_name}.fasta`, generated by executing `seqkit grep -f {species}_{domain_name=4th_column}.list INPUT_FOLDER/{species_name}_clean.fasta`.
   - A file named `{species}_{domain_name}_domain.bed`, including data from the first, 18th, and 19th columns. Subtract 1 from the number in the 18th column and append the domain name to the end column.
   - A file named `{species}_{domain_name}_domain.fasta`, created by running `seqkit subseq --update-faidx --bed {species}_{domain_name}_domain.bed INPUT_FOLDER/{species_name}_clean.fasta`.

5. Identify conflicts:
   - Generate `{species}_conflict.list` with Gene ID, 7tm_1, 7tm_2.
   - Create `{species}_conflict.fasta`.
   - Produce `{species}_conflict_domain.bed`, including data from the first, 18th, and 19th columns, append the domain name to the last column, and subtract 1 from the 18th column number.
   - Form `{species}_conflict_domain.fasta` by executing `seqkit subseq --update-faidx --bed {species}_conflict_domain.bed INPUT_FOLDER/{species_name}_clean.fasta`.

6. Construct a table:
   - Use species names as row identifiers and domain names as column headers.
   - Name the file `{OUTPUT}_counts.txt`.
   - the table is under `output` folder.

7. Generate WebLogo:
   - Utilize results from step 4, specifically `{species}_{domain_name}_domain.fasta`.
   - Align sequences using MUSCLE and then create the WebLogo for each species.
   - the output will be under species folder.

8. Combine domain sequences:
   - Combine `{species}_{domain_name}_domain.fasta` files from step 4 into a single file across species.
   - the table is under `output` folder.

9. Script options:
   - Include an `--output` option for specifying the output directory, with `output` as the default.
   - Add a `--CPU` option with a default value of 2.
   - Add an option to enable or disable WebLogo generation, disabled by default.

## Bugs
1. the fasta file out was overwrited not appended. This affect that it has only one fasta file.

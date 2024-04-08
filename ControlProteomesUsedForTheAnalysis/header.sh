#!/bin/bash

# Check if a file name is provided as an argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <fasta_file>"
    exit 1
fi

# Input FASTA file
fasta_file=$1

# Counter for sequence numbering
counter=1

# Process the FASTA file
while read line; do
    # Check if the line starts with ">"
    if [[ $line == ">"* ]]; then
        echo ">Ofus${counter}"
        ((counter++))
    else
        echo "$line"
    fi
done < $fasta_file

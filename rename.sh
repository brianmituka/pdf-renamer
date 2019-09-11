#!/bin/bash
##check if pdfGrep is installed and there are pdf files in the directory
if ! [ -x "$(command -v pdfgrep)" ]; then
  echo 'Error: pdfgrep is not installed download it to continue' >&2
  exit 1
  else
  echo 'pdfgrep installed proceeding to search pdfs' 
fi

count=`ls -1 *.pdf 2>/dev/null | wc -l`

if [ $count = 0 ]; then
    echo "No pdf in the directory exiting....."
    exit 1
    else 
    echo "Pdfs found in the directory proceeding to rename"
fi

## FIX for files with spaces in the titles
#Find all the pdfs in a directory
#fetch the first line from every pdf, 
# remove any spaces and join the whole word and use it to rename the file
# if the first line is empty, move to the next line until you find one 
# with text that you can use to rename the file.
# The filenames should'nt have any spaces.
# tr -s " " |
 rename_pdf_files(){
  for i in *.pdf
  do
    initial_position=1
    firstline=$(pdfgrep '' $i | head -n $initial_position | awk '{ gsub (" ", "", $0); print}')
    if [ "$firstline" = "" ]; then
      initial_position=$((initial_position+1))
      echo "Skipped $initial_position lines"
      firstline=$(pdfgrep '' $i | head -n $initial_position | awk '{ gsub (" ", "", $0); print}')
      echo "first line set to:: $firstline"
      mv -v "$i" "${firstline#?}.pdf"
    else 
      mv -v "$i" "${firstline#?}.pdf"
    fi
  done
}

rename_pdf_files



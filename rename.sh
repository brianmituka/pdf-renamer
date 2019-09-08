
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

##FINSI
for i in *.pdf
do 
 o=$(pdfgrep '' devopsfordevelopers.pdf | head -n 1)
 echo $o
 mv -v "$i" "${o#?}.pdf"
done


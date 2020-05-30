			####Script 1. Download the raw data
			#### Diego Montesinos Valencia 2020

	### The data to download correspond to gene expression profiles 
	### in the heart tissue of mice (see README) (Llamas et al., 2009)
	### These data are found in the GEO database by ID GSE15354 
	### at http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE15354


## Download the file containing the raw data
curl -s "https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE15354&format=file&file=GSE15354%5Fraw%2Etxt" > ../data/DATA_RAW.txt

## NOTE: Because the file "DATA_RAW.txt" contains information in the first 5 lines that we will not need,
# the following command is used to remove these lines
sed -i "1,5d" ../data/DATA_RAW.txt

## Download the information of all the mouse annotations (corresponding to the data in the file "DATA_RAW.txt")
# and write it to a file named "MouseRef-8_annot_full.txt"
curl -s "https://raw.githubusercontent.com/u-genoma/BioinfinvRepro/master/Unidad7/DE_tutorial/MouseRef-8_annot_full.txt" > ../data/MouseRef-8_annot_full.txt

## Download the file containing the hybridization design 
# and write it to a file named "YChrom_design.csv"
curl -s "https://raw.githubusercontent.com/u-genoma/BioinfinvRepro/master/Unidad7/DE_tutorial/YChrom_design.csv" > ../data/YChrom_design.csv








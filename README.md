# README

> Clustering of microarray data
>
> Diego Montesinos Valencia
> Final project, 2020-2



## General information

This repository contains the scripts (identified in the "bin" directory) and the data (determined in the "data" directory) used in the final project of the subject "Introduction to bioinformatics and reproducible research for genetic analysis" 2020-2 .

In the "bin" directory you will find the scripts used to perform a simple example of clustering of data from a small group of microarray data.

- Script_1_DMV.sh: it contains the commands (written in the GNU Bash language) used to download the data and create the files (.txt and .csv) that are necessary for the analysis. **Note:** all the data is downloaded and saved in the “data” directory, therefore it is necessary to define the “bin” directory as the working directory when executing this script.

- Script_2_DMV.R: It contains the commands (written in the R language) used to import the data files from the "data" directory into RStudio and perform the functional analysis. These commands are based on the workflow reported by Ricardo Verdugo (2009, 2011) on "Differential expression analysis in R ”and in the tutorial created by Verdugo & Oróstica (2020) called “Functional analysis of microarray data ”. **Note:** to successfully run this script it is necessary to have [R](https://www.r-project.org/) and [RStudio](https://rstudio.com/) installed, as well as the corresponding package (see the section *Analyses run*).

  

> References
>
> - Verdugo, R.A., Deschepper, C.F., Muñoz, G., Pomp, D. & Churchill, G.A. (2009). Importance of randomization in microarray experimental designs with Illumina platforms. *Nucleic Acids Research, 37(17)*, 5610–5618 pp. doi:10.1093/nar/gkp573 



## Data used

Data for this project was taken from the [GEO for ID GSE15354](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE15354) data base corresponding to the publication titled **"Chromosome Y Variants From Different Inbred Mouse Strains Are Linked to Differences in the Morphologic and Molecular Responses of Cardiac Cells to Postpubertal Testosterone"** ([Llamas et al., 2009](https://bmcgenomics.biomedcentral.com/articles/10.1186/1471-2164-10-150)).

The data found in the "data" directory of this repository correspond to gene expression profiles of the heart tissue of male mice (done in the Illumina Mouse-Ref8 platform) ([Llamas et al., 2009](https://bmcgenomics.biomedcentral.com/articles/10.1186/1471-2164-10-150)). The original authors assessed the effect of genetic variation on the mouse Y chromosome on the size of cardiomyocytes as well as their possible dependence on such effects on testosterone levels ([Llamas et al., 2009](https://bmcgenomics.biomedcentral.com/articles/10.1186/1471-2164-10-150)).
The following table summarizes the experimental design that the authors used, this indicates the nomenclature used as well as the strain, treatment and the number of mice they used (in total 16 adult male rats were processed).

| Nomenclature |                       Attribute                        | Number of mice |
| :----------: | :----------------------------------------------------: | :------------: |
|     B.I.     |      Intact (untreated) mice of strain C57BL / 6J      |       4        |
|     B.C.     |   Castrated mice (treated) of the strain C57BL / 6J    |       4        |
|    BY.I.     |   Intact (untreated) mice of strain C57BL / 6J-chrY    |       4        |
|    BY.C.     | Castrated mice (treated) of the strain C57BL / 6J-chry |       4        |

They subsequently obtained the RNA and hybridized it with BeadChips Illumina MouseRef-8 v2.0 containing eight microarrays with 25,697 probes each ([Llamas et al., 2009](https://bmcgenomics.biomedcentral.com/articles/10.1186/1471-2164-10-150)). However, in this case 5000 probes were chosen to streamline and simplify the analysis.



> References
>
> - Llamas, B., Verdugo, R.A., Churchill, G.A. & Deschepper, C.F. (2009). Chromosome Y variants from different inbred mouse strains are linked to differences in the morphologic and molecular responses of cardiac cells to postpubertal testosterone. *BMC Genomics, 10(1), 150.* doi:10.1186/1471-2164-10-150 



## Analyses run

#### Objetive

- Using a small group of microarray data from the gene expression profiles of the heart tissue of male mice (performed on the Illumina Mouse-Ref8 platform) (Llamas et al., 2009), perform the clustering of said data from an array of normalized data.

  

#### Initial steps

Before starting, as mentioned above, you need to have R and RStudio installed. In particular, this analysis was carried out using [R](https://www.r-project.org/) version 4.0.0 (2020-04-24) "Arbor Day" and [RStudio](https://rstudio.com/) version 1.2.5042.

In addition, it is necessary to have the following packages in RStudio:

- [preprocessCore](https://github.com/bmbolstad/preprocessCore)

- [ggplot2](https://ggplot2.tidyverse.org)

- [factoextra](https://CRAN.R-project.org/package=factoextra)



#### Get the data

In the first instance, it is necessary to execute the file “Script_1_DMV.sh” from the terminal to obtain the data and the following files necessary for the analysis.

- DATA_RAW.txt: which contains all the raw data of the microarrays in the Illumina format.
- MouseRef-8_annot_full.txt: this contains all the annotations of the mouse probes.
- Ychrom_design.csv: which contains the table with the design of the hybridizations.

**Note:** All the data downloaded in this step come from the publication of [Llamas et al. (2009)](https://bmcgenomics.biomedcentral.com/articles/10.1186/1471-2164-10-150) and the workflow reported by Ricardo Verdugo (2011) entitled ["Diferential expression analysis in R"](https://github.com/u-genoma/BioinfinvRepro/blob/master/Unidad7/Tutorial_de_expresion_diferencial_en_R.md).



#### Functional analysis of microarray data in RStudio

Once all the aforementioned files have been obtained, it is necessary to open the file “Script_2_DMV.R” in RStudio to carry out the "Functional analysis of microarray data". During this step and in general, the workflow is summarized in the following points.

- Import the raw data and choose only 5000 samples.

- Import the file with the annotations and the table with the design of the hybridizations.

- Probe filter quality control.

- Data normalization.

- Probe Filtering.

- Get file with normalized data.

- Import the file with the normalized data.

- Delete missing data.

- Determine the number of groups using k-means.

- Cluster analysis of K means.

- Get the clustering graph.

- Obtain the hierarchical clustering graph.

  

**Note:** the workflow mentioned in this step is based on the tutorial created by Ricardo Verdugo (2011) called ["Diferential expression analysis in R"](https://github.com/u-genoma/BioinfinvRepro/blob/master/Unidad7/Tutorial_de_expresion_diferencial_en_R.md), in the tutorial created by Verdugo & Oróstica (2020) called ["Functional analysis of microarray data"](https://github.com/u-genoma/BioinfinvRepro/blob/master/Unidad7/Tutorial_Analisis_funcional_de_datos_de_microarreglos.md) and in the  [Cluster Analysis, Quick-R, DataCamp](https://www.statmethods.net/advstats/cluster.html). **For more details see the files ["Final_project_report_DMV.Rmd"](https://github.com/dmephisto/Proyecto_Bionf2020/blob/master/Final_project_report_DMV.Rmd) and ["Final_project_report_DMV.html"](https://github.com/dmephisto/Proyecto_Bionf2020/blob/master/Final_project_report_DMV.html) which are the reports of the analysis performed**.



*At the following link you can access the summary and discussion of the results of the analysis ["DMV_Report"](https://github.com/dmephisto/DMV_Report/blob/master/DMV_Report.md).*



> References
>
> 1. RStudio Team (2020). RStudio: Integrated Development for R. RStudio, Inc., Boston, MA URL http://www.rstudio.com/.
> 2. Ben Bolstad (2020). preprocessCore: A collection of pre-processing functions. R package version 1.50.0. https://github.com/bmbolstad/preprocessCore.
> 3. Wickham H (2016). *ggplot2: Elegant Graphics for Data Analysis*. Springer-Verlag New York. ISBN 978-3-319-24277-4, [https://ggplot2.tidyverse.org](https://ggplot2.tidyverse.org/).
> 4. Alboukadel Kassambara and Fabian Mundt (2020). factoextra: Extract and Visualize the Results of Multivariate Data Analyses. R package version 1.0.7. https://CRAN.R-project.org/package=factoextra.

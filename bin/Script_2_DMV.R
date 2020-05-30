## Script 2. Functional analysis of microarray data in RStudio
### Diego Montesinos Valencia 2020

### This tutorial is a variant of the tutorial created by Dr. Ricardo A. Verdugo (2011)
### This experiment is an expression profile made on the Illumina Mouse-Ref8 platform
### Focuses on evaluating the effect of genetic variation on the mouse Y chromosome on the size of cardiomyocytes.
### NOTE: It is necessary to have installed the packages "preprocessCore", "factoextra" and "ggplot2"

### Initial issues
# -----------------------------------------------------------------------------------------------------------

# Choose bin as the working directory, this is where this same script is located

# Create the output directory, it will be found in the "../data" directory
outdir     <- "../data/output"

if(!file.exists(outdir)) {
  dir.create(outdir, mode = "0755", recursive=T)
}

# Load and prepare microarray information in Illumina format
# -----------------------------------------------------------------------------------------------------------
RAW  <- read.delim("../data/DATA_RAW.txt", header = TRUE) # Upload all raw information

# Choose only 5000 rows (Only 5000 are chosen to streamline analysis)
Data.Raw <- RAW[sample(nrow(RAW), 5000), ] 

signal    <- grep("CDR", colnames(Data.Raw)) # Column vector with data
detection <- grep("Detection.Pval", colnames(Data.Raw)) # Column vector with p-values
head(Data.Raw) # Observe "Data.Raw"

# Load annotations from the probe
annot <- read.delim("../data/MouseRef-8_annot_full.txt") # Load the file with all the annotation information
data_names <- rownames(Data.Raw)
annot = annot[row.names(annot)%in%data_names,] # Choose only 5000 "Data.Raw" annotations

head(annot) # Observe "annot"

# Load hybridization design
design <- read.csv("../data/YChrom_design.csv")
head(design) # Observe "design"

# QC probe filtering
# -----------------------------------------------------------------------------------------------------------
# Because not all probes have the same quality from sequence alignment to genome
table(annot$ProbeQuality)

# We will group 'Bad' with 'No match' as bad and everything else as good
probe_qc <- ifelse(annot$ProbeQuality %in% c("Bad", "No match"), "Bad probes", "Good probes")

# Since poor quality probes tend to have a lower signal than good probes it is recommended to remove them
Data.Raw <- Data.Raw[probe_qc %in% "Good probes",]
annot    <- annot[probe_qc %in% "Good probes",]

# Create raw data matrix
rawdata           <- as.matrix(Data.Raw[,signal])
rownames(rawdata) <- Data.Raw$PROBE_ID
colnames(rawdata) <- design$Sample_Name

# Data normalization
# -----------------------------------------------------------------------------------------------------------
library(preprocessCore)
normdata           <- normalize.quantiles(rawdata) 
colnames(normdata) <- colnames(rawdata)
rownames(normdata) <- rownames(rawdata)

# Filtering the probe
# -----------------------------------------------------------------------------------------------------------
# Create a vector or P / A calls for each probe using detection probabilities calculated by BeadStudio
probe_present      <- Data.Raw[,detection] < 0.04
detected_per_group <- t(apply(probe_present, 1, tapply, design$Group, sum))

present  <- apply(detected_per_group >= 2, 1, any)
normdata <- normdata[present,]
annot    <- annot[present, ]

# Write the file "normdata.txt" with the data already normalized
write.table(normdata, file.path(outdir, "normdata.txt"), sep="\t", row.names=T) 

# Continue with the functional analysis of the data
# -----------------------------------------------------------------------------------------------------------
# Import the normalized data (contained in the file "normdata.txt")
mydata <- read.delim("../data/output/normdata.txt", as.is=T)

# Change column names to make it easier to identify
# the experimental group in the following graphs
design <- read.csv("../data/YChrom_design.csv")
colnames(mydata) <- design$Group

# Delete as missing list and standardize variables
mydata <- na.omit(mydata)
mydata <- scale(mydata)

# Determine the number of groups using k-means
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(mydata,
                                     centers=i)$withinss)
plot(1:15, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares") 

# In this case, the k = 4 was taken as the inflection point

# K-Means Cluster Analysis
fit <- kmeans(mydata, 4) # 4 is the cluster solution

# Get cluster means
aggregate(mydata,by=list(fit$cluster),FUN=mean)

# Append cluster assignment
library(factoextra)
fviz_cluster(fit, data = mydata)
mydata <- data.frame(mydata, fit$cluster) 

# Hierarchical cluster
d <- dist(t(mydata), method = "euclidean") # Distance matrix("euclidean")
fit <- hclust(d, method="ward.D")
plot(fit, hang = -1, cex = 0.8) # Display dendogram
groups <- cutree(fit, k=4) # Cut tree into 4 clusters
rect.hclust(fit, k=4, border="red") # Draw dendogram with red borders around the 4 clusters

  
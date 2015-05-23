########################
# Reports
########################

library(tm)
library(Rgraphviz)
library(ggplot2)
library(gridExtra)

freq.data <- read.csv("~/mla_data/data/2012/CSV_files/freq.csv")
#d2 <- read.csv("~/mla_data/data/2013/CSV_files/freq.csv")
#d3 <- read.csv("~/mla_data/data/2014/CSV_files/freq.csv")

rev(freq.data)
freq.data <- as.data.frame(freq.data)
word.names <- head(freq.data$X, 10)
word.names <- rev(word.names)
word.freq <- head(freq.data$Total, 10)
word.freq <- rev(word.freq)

#################################
# 2012 word frequency plot
#################################

## Open PNG device and set location to save file
png("~/mla_data/plots/freq_2012.png", 600, 480)

	## Set plot dimensions 
	par(pin=c(4, 4))

	## Draw plot
	freq.plot <- barplot(word.freq, names.arg=word.names, horiz=TRUE, 
						 main="2012 Word Frequencies", ylab=NULL, 
						 xlab="Frequency", las=2, axes=FALSE)
	
	# Starting x-axis position for adding frequency totals to bars
	freq.pos <- 0.65		
	
	## Add frequency totals to bars	
	for(i in 1:length(word.freq)) {			
	text(freq.pos, labels=word.freq[i], pos=4, offset=.2)
	freq.pos <- freq.pos + 1.2
	}

	## Add bottom axis and numeric range
	axis(1, at=seq(0, 1200, 100))

## Close PDF device
dev.off()

##########################
# Correlation Cluster
##########################

# Load in an R data space image with a Document Term Matrix
load("~/mla_data/data/dtm.rda")

# Open a PNG device to save the image that contains the cluster
png("~/mla_data/plots/cor_cluster.png", 700, 500)

## Call a list of attributions to change the look of the cluster graph
defAttrs <- getDefaultAttrs()

# Plot the correlation cluster
plot(dtm, terms=findFreqTerms(dtm, lowfreq=250, highfreq=2000),
     corThreshold=0.12, attrs=list(node=list(shape = "ellipse", 
     fixedsize = TRUE, fillcolor="lightblue", height="2.6", 
     width="10.5", fontsize="14")))

# Turn off the PNG device
dev.off()

#############################
# Correlation Tables
#############################

# Create data frame from CSV file with top correlations to "rhetoric"
rhet.cor <- read.csv("~/mla_data/data/2012/CSV_files/rhet-cor.csv")

# Change the column name "X" to an empty space
colnames(rhet.cor)[1] <- " " 

# Set the data frame to the top 10 correlations
rhet.cor <- head(rhet.cor, 10)

# Open an PNG device to save the image that contains the table below
png("~/mla_data/visuals/rhet-cor_table.png", 400, 380)

# Create the table 
rhet.cor <- tableGrob(rhet.cor)
grid.arrange(rhet.cor)

# Turn off the PNG device
dev.off()



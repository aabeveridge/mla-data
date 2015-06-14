########################
# Reports
########################

library(tm)
library(Rgraphviz)
library(ggplot2)
library(gridExtra)
library(stringr)

#Read in the word frequency for the job description corpus
freq.data <- read.csv("./data/freq.csv")
rev(freq.data)
freq.data <- as.data.frame(freq.data)
word.names <- head(freq.data$X, 10)
word.names <- rev(word.names)
word.freq <- head(freq.data$Total, 10)
word.freq <- rev(word.freq)

#Creates date label for plots based on the name of the working directory
plot.date <- getwd()	
plot.date <- str_sub(plot.date, -4, -1)

#################################
# Word Frequency Plot
#################################

## Open PNG device and set location to save file
png("./visuals/freq_plot.png", 600, 480)

	## Set plot dimensions 
	par(pin=c(4, 4))
	
	## Draw plot
	freq.plot <- barplot(word.freq, names.arg=word.names, horiz=TRUE, 
						 main=paste(plot.date, "Word Frequencies", sep=" "), 
						 ylab=NULL, xlab="Frequency", las=2, axes=FALSE)
	
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
load("./data/dtm.rda")

# Open a PNG device to save the image that contains the cluster
png("./visuals/cor_cluster.png", 700, 500)

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

# Create data frames from CSV files with top correlations to "rhetoric,"
# "composition," "technical," "writing" 
rhet.cor <- read.csv("./data/rhet-cor.csv")
comp.cor <- read.csv("./data/comp-cor.csv")
writ.cor <- read.csv("./data/writ-cor.csv")
tech.cor <- read.csv("./data/tech-cor.csv")

# Change the column name "X" for the first column to the year of the data
colnames(rhet.cor)[1] <- plot.date
colnames(comp.cor)[1] <- plot.date
colnames(writ.cor)[1] <- plot.date
colnames(tech.cor)[1] <- plot.date 

# Set the data frame to the top 10 correlations
rhet.cor <- head(rhet.cor, 10)
comp.cor <- head(comp.cor, 10)
writ.cor <- head(writ.cor, 10)
tech.cor <- head(tech.cor, 10)

# Open an PNG device to save the image that contains the table below
png("./visuals/rhet-cor_table.png", 255, 275)

	# Create the table 
	rhet.cor <- tableGrob(rhet.cor)
	grid.arrange(rhet.cor)

# Turn off the PNG device
dev.off()

# Open an PNG device to save the image that contains the table below
png("./visuals/comp-cor_table.png", 255, 275)

	# Create the table 
	comp.cor <- tableGrob(comp.cor)
	grid.arrange(comp.cor)

# Turn off the PNG device
dev.off()

# Open an PNG device to save the image that contains the table below
png("./visuals/writ-cor_table.png", 255, 275)

	# Create the table 
	writ.cor <- tableGrob(writ.cor)
	grid.arrange(writ.cor)

# Turn off the PNG device
dev.off()

# Open an PNG device to save the image that contains the table below
png("./visuals/tech-cor_table.png", 255, 275)

	# Create the table 
	tech.cor <- tableGrob(tech.cor)
	grid.arrange(tech.cor)

# Turn off the PNG device
dev.off()

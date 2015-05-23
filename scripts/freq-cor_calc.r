library(tm)

## This is the script for calculating word frequencies and word
## correlations for an individual year. This script is written to 
## run in the year folder as working directory--assumming that there 
## is a "text" folder with separate job description *.txt files, and
## another folder called "data" for the *.csv files exported from
## this script.
  
## Read all texts into TM data structure called a Corpus
corpus <- VCorpus(DirSource("./text"))
	
## Remove unnecessary words and punctuation, reduce document, 
## stem the corpus, complete the stemmed words, and strip 
## extra white space 
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
other.words <- c("english", "will", "university", "applications", 
                 "application", "department", "candidates", "courses", "college", "professor",
                 "letter", "edu", "position")
corpus <- tm_map(corpus, removeWords, other.words)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
	
## Create Document Term Matrix out of MLA Corpus
dtm <- DocumentTermMatrix(corpus)

## Calculate the most frequent terms
freq <- data.frame(Total = sort(colSums(as.matrix(dtm)),
                                          decreasing=TRUE)) 
## Calculate and save top 50 word correlations for "writing"
writ.cor <- findAssocs(dtm, "writing", corlimit=0.0)
    
## Calculate and save top 50 word correlations for "rhetoric"
rhet.cor <- findAssocs(dtm, "rhetoric", corlimit=0.0)
    
## Calculate and save top 50 word correlations for "composition"
comp.cor <- findAssocs(dtm, "composition", corlimit=0.0)
  
## Calculate and save top 50 word correlations for "technical"
tech.cor <- findAssocs(dtm, "technical", corlimit=0.0)

## Write frequencies and correlations to CSV files
write.csv(head(freq, 50), "./CSV_files/freq.csv")
write.csv(head(writ.cor, 50), "./CSV_files/write-cor.csv")
write.csv(head(rhet.cor, 50), "./CSV_files/rhet-cor.csv")
write.csv(head(comp.cor, 50), "./CSV_files/comp-cor.csv")
write.csv(head(tech.cor, 50), "./CSV_files/tech-cor.csv")

## Save Document Term Matrix
save(dtm, file="~/mla_data/data/dtm.rda")

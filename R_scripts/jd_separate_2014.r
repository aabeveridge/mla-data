#######################################################
# Separate Job Descriptions into Individual Text Files
#######################################################

library(tm)
library(stringr)

## Read in the text data that has been pre-scrubbed from 
## the MLA PDFs with pdftotext comand line utility in Linux
mlatext <- scan("./raw/jil_eng_2014_8.txt", what="character", sep="\n")

## Set all characters to UTF-8
mlatext <- iconv(mlatext, "", "UTF-8")
	
## Change all text to lowercase
mlatext <- tolower(mlatext)

## Create a vector d with a listing of all lines in
## the text that match the pattern "apply to this position"
d <- grep("https://apply.interfolio.com/[[:alnum:]]", mlatext)

## Use the index of text positions from d to determine where
## individual job descriptions are in the raw text and then
## separate each job description into its own text file and
## save it to a fold. The 4 lines above each text description
## contain metadata type information like the University where
## the job is located, address, and URLs for job listing. The text
## in these 4 lines is saved in a corresponding metadata text file
## with the same number as its corresponding text file. 
for(i in 1:length(d)){
			
	## Locate beginning and end of job descriptions and beginning and
	## end of metadata related material
	jd_start <- d[i] + 1
	jd_next <- i + 1
	jd_end <- d[jd_next] - 4
	jd_head <- jd_start - 4
	jd_text <- mlatext[jd_start:jd_end]
	jd_meta <- mlatext[jd_head:jd_start]

	jd_text <- str_replace_all(jd_text, "-", " ")
	jd_text <- str_replace_all(jd_text, "/", " ")
	jd_text <- str_replace_all(jd_text, "(http|https)([^/]+).*", " ")	
		
	## Save raw text from inidivdual job descriptions into raw folder
	cat(jd_text, file=paste("./corpus/jd_000a", i, ".txt", sep=""))
	
	## Save metedata related material into meta folder
	cat(jd_meta, file=paste("./meta/meta_jd_000a", i, ".txt", sep=""))
}


    

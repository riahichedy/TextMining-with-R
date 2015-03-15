TEXTFILE="C:/Users/Chedy/Desktop/Formation/pg100.txt"
file.exists(TEXTFILE)
shakespeare=readLines(TEXTFILE)
length(shakespeare)
head(shakespeare)
tail(shakespeare)
shakespeare=shakespeare[-(1:173)]
shakespeare=shakespeare[-(124195:length(shakespeare))]
shakespeare = paste(shakespeare, collapse = " ")
nchar(shakespeare)
shakespeare = strsplit(shakespeare, "<<[^>]*>>")[[1]]
length(shakespeare)
(dramatis.personae <- grep("Dramatis Personae", shakespeare, ignore.case = TRUE))
length(shakespeare)
shakespeare = shakespeare[-dramatis.personae]
length(shakespeare)

library(tm)
doc.vec <- VectorSource(shakespeare)
doc.corpus <- Corpus(doc.vec)
summary(doc.corpus)

doc.corpus <- tm_map(doc.corpus, tolower)
doc.corpus <- tm_map(doc.corpus, removePunctuation)
doc.corpus <- tm_map(doc.corpus, removeNumbers)
doc.corpus <- tm_map(doc.corpus, removeWords, stopwords("english"))

library(SnowballC)
doc.corpus <- tm_map(doc.corpus, stemDocument)
doc.corpus <- tm_map(doc.corpus, stripWhitespace)
inspect(doc.corpus[8])
corpus_clean <- tm_map(doc.corpus, PlainTextDocument)

TDM <- TermDocumentMatrix(corpus_clean)
TDM
DTM <- DocumentTermMatrix(corpus_clean)
inspect(DTM[1:10,1:10])

findFreqTerms(TDM, 2000)
findAssocs(TDM, "love", 0.8)

TDM.common = removeSparseTerms(TDM, 0.1)
dim(TDM)
dim(TDM.common)
inspect(TDM.common[1:10,1:10])

library(slam)
TDM.dense <- as.matrix(TDM.common)
TDM.dense
object.size(TDM.common)

library(reshape2)
TDM.dense = melt(TDM.dense, value.name = "count")
head(TDM.dense)

library(ggplot2)

ggplot(TDM.dense, aes(x = Docs, y = Terms, fill = log10(count))) +
 geom_tile(colour = "white") +
 scale_fill_gradient(high="#FF0000" , low="#FFFFFF")+
 ylab("") +
 theme(panel.background = element_blank()) +
 theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())
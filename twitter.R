# Topic modeling in Twitter

library(tm);
library(topicmodels);
library(RTextTools);
library(twitteR); 
library(rjson);


#Authentification
api_key <- "y2WDtBoa8RN2tobXJ7vyE3Sq2"
api_secret <- "92tZvQlwfzCkRpR977qdRbdsW8jReIFoncH4YVsdy2CypQwjom" 
access_token <- "3094831522-tgA7HOeFZdKgMdmsjvgah7dg8nYBBZG4Tslw4nE" 
access_token_secret <- "r7yQGb3zHjJzTsZBk5Jd6gHYMkwlLpQO7VMpjQCz8MR3c" 
setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

twitter_feed <- searchTwitter('Sharing_economy', n=400); 
df <- do.call("rbind", lapply(twitter_feed, as.data.frame));
myCorpus <- Corpus(VectorSource(df)); 
myCorpus = tm_map(myCorpus, content_transformer(tolower));
myCorpus = tm_map(myCorpus, removePunctuation);
myCorpus = tm_map(myCorpus, removeNumbers);
myStopwords = c(stopwords('english'), "available", "via");
idx = which(myStopwords == "r");
myStopwords = myStopwords[-idx];
myCorpus = tm_map(myCorpus, removeWords, myStopwords); 
dictCorpus = myCorpus; myCorpus = tm_map(myCorpus, stemDocument); 
myCorpus = tm_map(myCorpus, stemCompletion, dictionary=dictCorpus); 
myDtm = DocumentTermMatrix(myCorpus, control = list(minWordLength = 1)); 
findFreqTerms(myDtm, lowfreq=2);
myDtm
rowTotals <- apply(myDtm , 1, sum) #Find the sum of words in each Document
dtm.new   <- myDtm[rowTotals> 0, ]


library(wordcloud);
m = as.matrix(dtm.new);
v = sort(colSums(m), decreasing=TRUE);
myNames = names(v);
k = which(names(v)=="miners");
myNames[k] = "mining";
d = data.frame(word=myNames, freq=v);
wordcloud(d$word, random.color=FALSE, d$freq, min.freq=20);




lda <- LDA(m, 10)
terms(lda,5)
topics(lda)
library(jsonlite)
#Perigon
#according to NPR, sinclair runs 190 news TV stations, and uses it to run similar programs pushing their 
#agenda from state to state. While local TV news stations =! written news, an analysis of headlines (the most
#important part of messaging according to the 80/20 rule) could give us an idea of whether the same tactic
#is used in written local news. For this, I will need the publisher, print date, headline, description, content,
#medium, and maybe even the URL just in case I want to scrape that too. Additionally I can use URL to make sure I
#do not have any duplicates

urlSpitter <- function(x){
  j<-tryCatch({
    j<-paste('https://api.goperigon.com/v1/all?type=local&from=',as.character(x),'&size=100&country=us&apiKey=56fb9eba-67d2-4f0d-94e8-a46cc4ab6f91',sep='')
    
    return(j)
  },
  error = function(cond){
    return(NULL)
  }
  )
  return(j)
}
toPostDB <- function(df){
  df<-data.frame
}

jsn<-data.frame(fromJSON(urlSpitter(Sys.Date()))[3])
jsnred<-data.frame(jsn[1],jsn[2],jsn[3],jsn[5,1],jsn[9],jsn[12],jsn[13],jsn[14],jsn[15])
print(jsn[1,5][1])
# before the loop make sure to add a thingy that creates the table as follows
# dbExecute(config,'CREATE TABLE election_news (
# url CHAR,
# by_line CHAR,
# article_id VARCHAR(50),
# source_url CHAR,
# pub_date VARCHAR(25),

# headline CHAR,
# description CHAR,
# content CHAR,
# medium VARCHAR(12)
# )')


#export .renviron=jsn
#the environment name comes first rememebre 
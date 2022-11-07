library(jsonlite)
library(RPostgres)
#Perigon
#according to NPR, sinclair runs 190 news TV stations, and uses it to run similar programs pushing their 
#agenda from state to state. While local TV news stations =! written news, an analysis of headlines (the most
#important part of messaging according to the 80/20 rule) could give us an idea of whether the same tactic
#is used in written local news. For this, I will need the publisher, print date, headline, description, content,
#medium, and maybe even the URL just in case I want to scrape that too. Additionally I can use URL to make sure I
#do not have any duplicates

#start with making the DB outside of the loop
config <- dbConnect(RPostgres::Postgres(),
                         dbname='railway',
                         host='containers-us-west-91.railway.app',
                         port='7332',
                         user='postgres',
                         password='UNyfDxQclkagFuWAA34M'
)
#dbExecute(config,'CREATE TABLE local_news (
#  url CHAR,
#  by_line CHAR,
#  article_id VARCHAR(50),
#  source_url CHAR,
#  pub_date VARCHAR(25),
#  headline CHAR,
#  description CHAR,
#  content CHAR,
#  medium VARCHAR(12)
#)')
craftURL <- function(day,timest){
  j<-tryCatch({
    j<-paste('https://api.goperigon.com/v1/all?type=local&from=',day,'T',timest,'&size=100&country=us&apiKey=56fb9eba-67d2-4f0d-94e8-a46cc4ab6f91',sep='')
    return(j)
  },
  error = function(cond){
    return(NULL)
  }
  )
  return(j)
}


toDB <- function(jsn,config){
  for(i in 1:nrow(jsn)){ #remember first value is the row, second is the column
    dbExecute(config, "INSERT INTO local_news VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9)",
              list(jsn[i,1],jsn[i,2],jsn[i,3],jsn[i,5][1],jsn[i,9],jsn[i,12],jsn[i,13],jsn[i,14],jsn[i,15]))
}
}
  
  
  
repeat {
  toScrape<-craftURL(Sys.Date(),substr(Sys.time(),12,19))
  Sys.sleep(10800)#grabbing url then sleeping so that there is time to accumulate news
  jsn<-read_json(toScrape)
  toDB(jsn,config)
}
  
  
  
  
  
  
  
  
  
  
  
  
  
  

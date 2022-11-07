FROM rocker/rstudio

WORKDIR /app

RUN R -e "install.packages('jsonlite',dependencies=TRUE, repos='http://cran.rstudio.com/')"

RUN R -e "install.packages('RPostgres',dependencies=TRUE, repos='http://cran.rstudio.com/')"

COPY local_news_scraper.r .

CMD ["R", "-f", "testing.r"]
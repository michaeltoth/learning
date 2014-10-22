library(httr)
library(jsonlite)
library(XML)

# Twitter API
my_app = oauth_app("twitter", key="XXXX", secret="XXXX")
sig = sign_oauth1.0(my_app, token="XXXX", token_secret="XXXX")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)

json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]


# Github API

oauth_endpoints("github")

myapp <- oauth_app("github", "XXXX", "XXXX")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
json1 = content(req)
json2 = jsonlite::fromJSON(toJSON(json1))

json2[json2$name == "datasharing",]$created_at


# Running SQL on data frames with sqldf package

acs <- read.csv("getdata_data_ss06pid.csv")
library("sqldf")

sqldf("select pwgtp1 from acs where AGEP < 50")
sqldf("select distinct AGEP from acs")


# Getting data from a URL

# Parse HTML
req <- GET("http://biostat.jhsph.edu/~jleek/contact.html")
html <- content(req,as="text")
parsedHtml = htmlParse(html,asText=TRUE)

# Read line-by-line
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
htmlCode
nchar(htmlCode[c(10,20,30,100)])


# Reading data from fixed-width-file

# Negative length means skip a line
lengths <- c(-1,9,-5,4,-1,3,-5,4,-1,3,-5,4,-1,3,-5,4,-1,3)
data <- read.fwf("getdata_wksst8110.for",lengths,skip=4)

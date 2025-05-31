#############################################################
##   PACKAGES 
#############################################################

library(RMySQL)
library(dplyr)
library(lubridate)
library(ggplot2)

#############################################################
##   CONNECT TO MYSQL  +  LOAD VIRAL DATA
#############################################################
con <- dbConnect(MySQL(),
                 user = "DB_USER",   
                 password = "DB_PASS",    
                 dbname = "sensordata",
                 host = "hostname",
                 port = 3306)

virusdata <- dbGetQuery(con, "SELECT * FROM sensordata")

summary(virusdata)
virusdata$id <- as.integer(virusdata$id)
str(virusdata)

virusdata$virusname       <- as.factor(virusdata$virusname)
virusdata$virustype       <- as.factor(virusdata$virustype)
virusdata$sampledate <- ymd(virusdata$sampledate)
summary(virusdata$sampledate)
month_num <- month(virusdata$sampledate)
season_lookup <- c(
  "Winter", "Winter",        
  "Spring", "Spring", "Spring",   
  "Summer", "Summer", "Summer",   
  "Fall",   "Fall",   "Fall",     
  "Winter"
)

virusdata$season <- factor(                   
  season_lookup[month_num],
  levels = c("Winter", "Spring", "Summer", "Fall"),
  ordered = TRUE
)

virusdata$season <- factor(
  virusdata$season,
  levels = c("Winter", "Spring", "Summer", "Fall")   
)

############################################################# 
# Fit Model 1: Full Model 

reg1 <- lm(partsperbillion ~ sampleweek + totalreads + virustype, data = virusdata)
yhat1 <- predict (reg1) 
e1 <- virusdata$partsperbillion-yhat1 
plot (e1,yhat1) 
summary(reg1)   

############################################################## 
# Fit Model 2: Quadratic 
x1sq <- virusdata$sampleweek^2 
reg2 <- lm(virusdata$partsperbillion ~ virusdata$sampleweek + x1sq) 
yhat2 <- predict (reg2) 
e2 <- virusdata$partsperbillion-yhat2 
plot (e2,yhat2) 
summary(reg2)   

################################################################ 
# Fit Model 3:  Choice 
reg3 <- lm(partsperbillion ~  totalreads + virustype + season, data = virusdata) # add explanatory variables 
yhat3 <- predict (reg3) 
e3 <- virusdata$partsperbillion-yhat3 
plot (e3,yhat3) 
summary(reg3)   
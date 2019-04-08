library(tidyverse)
library(flexdashboard)
library(shiny)
library(datasets)
#library(ggplot2)

# A function to load in our csv file and create a dataframe
LoadMyData <- function(file = 'games.csv'){
  games <- read.csv("games.csv", header=TRUE)
  # Convert the User Count and the User Score fields into numeric values
  games$User_Count <- as.numeric(as.character(games$User_Count))
  games$User_Score <- as.numeric(as.character(games$User_Score))
  return(games)
}

plot_1 <- function(dt){
  dt %>% ggplot(aes(x = log(Global_Sales),fill = Genre)) + geom_density(alpha = 0.4) + labs(x="Global Sales")
}


##
# Authors: Justin Hathaway, Jenkin Schibel, Anthony Moran
##

# Take in our csv file and create a dataframe
games = read.csv("games.csv", header=TRUE)

summary(games)

# excludes outliers that are far out there
hist(games$Global_Sales, main="Global Sales", col="blue",xlim=c(0,8), ylab="Number of Games", xlab="Copies Sold (in millions)", breaks=100)
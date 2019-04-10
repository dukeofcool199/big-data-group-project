##
# Authors: Justin Hathaway, Jenkin Schibel, Anthony Moran
##
install.packages("flexdashboard")

# Take in our csv file and create a dataframe
games = read.csv("games.csv", header=TRUE)

summary(games)

# excludes outliers that are far out there
plot(y=games$Global_Sales,x=games$Rating, main="Global Sales", col="blue",ylab="Number of Games", xlab="Copies Sold (in millions)", breaks=100)

barplot.default(games$Global_Sales)
lm(games$Global_Sales ~ games$Rating)

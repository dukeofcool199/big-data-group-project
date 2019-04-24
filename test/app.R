#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Feature Influence on NA_Sales"),
   
   # Sidebar with a slider input for number of bins 
   
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
     library(gbm)
     data = read.csv("Video_Games_Sales_as_at_22_Dec_2016.csv")
     colnames(data)
     clean = data
     clean.omit = na.omit(clean)
     clean.omit = clean.omit[!(clean.omit$NA_Sales > 12),]
     
     clean.omit$Developer = as.numeric(as.factor(clean.omit$Developer))
     
     clean.omit$User_Score = as.numeric(as.character(clean.omit$User_Score))
     
     sample <- sample.int(n = nrow(clean.omit), size = floor(.3*nrow(clean.omit)))
     train <- clean.omit[sample, ]
     test  <- clean.omit[-sample, ]
     
     boost.vg=gbm(NA_Sales ~ Genre + Platform + Developer + Publisher + User_Score + Critic_Score, data=clean.omit[-sample,], distribution="gaussian",n.trees=5000,interaction.depth=8)
     
     tree.pred=predict(boost.vg,newdata=clean.omit[sample,],n.trees=5000)
     head(tree.pred)
     head(clean.omit[sample,]$NA_Sales)
     summary(boost.vg)
   })
}

# Run the application 
shinyApp(ui = ui, server = server)


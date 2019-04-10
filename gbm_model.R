data = read.csv("Video_Games_Sales_as_at_22_Dec_2016.csv")
colnames(data)
clean = data
clean.omit = na.omit(clean)
clean.omit = clean.omit[!(clean.omit$NA_Sales > 12),]

clean.omit$Developer = as.numeric(as.factor(clean.omit$Developer))

clean.omit$User_Score = as.numeric(as.character(clean.omit$User_Score))

sample <- sample.int(n = nrow(clean.tree), size = floor(.3*nrow(clean.tree)))
train <- clean.tree[sample, ]
test  <- clean.tree[-sample, ]

boost.vg=gbm(NA_Sales ~ Genre + Platform + Developer + Publisher + User_Score + Critic_Score, data=clean.tree[-sample,], distribution="gaussian",n.trees=5000,interaction.depth=10)

tree.pred=predict(boost.vg,newdata=clean.tree[sample,],n.trees=5000)
head(tree.pred)
head(clean.tree[sample,]$NA_Sales)
summary(boost.vg)
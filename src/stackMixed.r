setwd("/Users/Zoe/documents/kaggle/Feb2017/Kaggle_2SigmaRentalLI/")

library(dplyr)
library(data.table)

sub.result <- fread('data/test_stacknet.csv',select = c('V1'), col.names = c('listing_id'))
pred <- fread('data/sigma_stack_pred.csv')

sub.result$high <- pred$V1
sub.result$medium <- pred$V2
sub.result$low <- pred$V3

fwrite(sub.result,"output/submission_stack.csv")



# average 2 models
pred1 <- fread('output/submission_stack.csv')
pred2 <- fread('output/submission_byAnisotropic.csv')

pred <- pred1%>%inner_join(pred2,by='listing_id')

pred <- pred%>%mutate(high=(high.x+high.y)/2)
pred <- pred%>%mutate(medium=(medium.x+medium.y)/2)
pred <- pred%>%mutate(low=(low.x+low.y)/2)

pred <- pred%>%select(listing_id,high,medium,low)

fwrite(pred,"output/stack_averaged.csv")





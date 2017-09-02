library(outliers)
library(dplyr)
library(plyr)
price_iqr <- ddply(df, .(POSTDATE, MODEL, GB), summarize, upperQ=fivenum(POSTPRICE)[4], lowerQ=fivenum(POSTPRICE)[2], IQR=upperQ-lowerQ)
price_iqr[1:10]
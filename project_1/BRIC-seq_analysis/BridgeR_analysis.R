library(BridgeR)
library(ggplot2)
arg1 = commandArgs(trailingOnly=TRUE)[1]

files <- c(arg1)
hour <- c(0,1,1.5,2,3,4,5,6,8,10,12)
group <- c("HeLa_ver2")
InforColumn <- 4

BridgeRCore(InputFiles = files,
            InforColumn=4,
            group = group,
            hour = hour,
            RPKMcutoff=0.5,
            RelRPKMFig=F,
            SelectNormFactor=T,
            CutoffDataPointNumber = 4,
            CutoffDataPoint1 = c(0.25,0.5,0.75,1,1.5,2),
            CutoffDataPoint2 = c(8,10,12),
            ThresholdHalfLife = c(8,12),
            CutoffRelExp=0.001,
            ModelMode="R2_selection")
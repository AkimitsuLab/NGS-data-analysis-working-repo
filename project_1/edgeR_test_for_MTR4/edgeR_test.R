#File name
args1 = commandArgs(trailingOnly=TRUE)[1]
args2 = commandArgs(trailingOnly=TRUE)[2]
args3 = commandArgs(trailingOnly=TRUE)[3]

library(edgeR)

input_file1 <- read.table(args1, header = F, row.names = 1)

count <- (input_file1)[,c(6,13, 20, 27)]

#colnames(count) <- c("no_infection_2h", "wt_2h")
colnames(count) <- unlist(strsplit(args2, ',')) 

#group <- factor(c("no_infection_2h", "wt_2h"))
group <- unlist(strsplit(args3, ',')) 

d <- DGEList(counts = count, group = group)
d <- calcNormFactors(d)
d <- estimateGLMCommonDisp(d)
result <- exactTest(d)
result_table <- result$table

output_file <- cbind(count, result_table)

write.table(output_file, quote = F, sep = "\t", file = paste("edgeR_test_",paste(unlist(strsplit(args2, ',')), collapse='_'),".txt", sep=""))


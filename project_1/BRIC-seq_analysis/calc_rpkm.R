#File name
args = commandArgs(trailingOnly=TRUE)

flg <- 0
result_file <- data.frame()
for (arg in args) {
    input_file <- read.table(arg, header = F, row.names = 1)[6]
    total_compatible_reads <- sum(input_file[,1])
    rpm <- (input_file[,1] / total_compatible_reads * 1000000)
    tmp_file <- cbind(input_file, rpm)
    if (flg == 0) {
        flg <- 1
        result_file <- tmp_file
    }else{
        result_file <- cbind(result_file, tmp_file)
    }
}

write.table(result_file, quote = F, sep = "\t", col.name = F, file = paste("BridgeR_input_file.tmp", sep=""))

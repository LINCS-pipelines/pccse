
setwd("./example/")
system("./start.bash")
source("pccse_processing.R")

setwd("./example/")
system("./start.bash")
source("pccse_processing.R")

GCPprocessGCTMaster("LINCS_GCP_Plate53_annotated_minimized_2017-08-17_14-57-14.gct",log2=FALSE)
P100processGCTMaster("LINCS_P100_DIA_Plate53_annotated_minimized_2017-08-30_09-40-00.gct",log2=FALSE)

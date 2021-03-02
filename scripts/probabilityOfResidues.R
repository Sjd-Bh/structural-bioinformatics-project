load("../data/GBR.RData")
load("../data/BR_list.RData")
load("../data/contact_list.RData")


## calculation probability of GBR residues to be in contact with ligand
res_prob = c()
for (i in 1:length(GBR)) {
  GBR_resid = GBR[i]
  total=0
  incident=0
  for (j in 1:length(BR_list)) {
    BR_resid=unlist(BR_list[j])
    found1 <- GBR_resid %in% BR_resid
    if (found1==TRUE) {
      total = total + 1
    }
    contact_resid = unlist(contact_list[j]) 
    found2 <- GBR_resid %in% contact_resid 
    if (found2==TRUE) {
      incident = incident + 1
    }
    
  }
  res_probability = incident/total
  res_prob = c(res_prob,res_probability)
  
}

GBR_prob <- data.frame(GBR_residues = residues,probability = res_prob)
x <- which(GBR_prob[,2]>=0.5)
GBR_0.5 <- GBR[x,]

#########################################
## histogram plot for GBR probability
pdf(file = "prob.pdf") 
ggplot(GBR_prob) +
  geom_linerange(
    aes(x = GBR_residues, ymin = 0, ymax = probability), 
    color = "#E7B800", size = 1.5
  )+ theme(axis.text.x=element_text(angle=90, hjust=1))

dev.off()

#########################################

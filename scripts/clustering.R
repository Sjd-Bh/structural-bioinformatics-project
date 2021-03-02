library(bio3d)

## create a complete rmsd
s <- read.table("../data/rmsd.txt")
s <- as.matrix(s)
e <-  s + t(s)

## plottin a histogram for rmsd matrix
hist(e, breaks=40, xlab="RMSD (Å)", main="Histogram of RMSD")


pdbfiles <- c("2IQG_F2I" ,"2P83_MR0" ,"2QK5_CS5" ,"2QMD_CS7", "2QMF_CS9" ,
              "2QMG_SC6" ,"2QP8_SC7" ,"2VKM_BSD" ,"3CIB_314", "3CIC_316", 
              "3CID_318" ,"3IVH_1LI" ,"3IVI_2LI" ,"3IXJ_586" ,"3IXK_929", 
              "3K5C_0BI" ,"3LNK_74A" ,"3LPI_Z74" ,"3LPJ_Z75", "3LPK_Z76" ,
              "3N4L_842" ,"3NSH_957", "3R2F_PB0" ,"3SKG_PB8", "3VEU_0GO", 
              "4DPF_0LG" ,"4DPI_0N1" ,"4GID_0GH" ,"4I0I_957", "4I0J_842"
)

save(pdbfiles,"pdb_files.RData")
colnames(e) <- pdffiles
rownames(e) <- pdffiles
hc.rd <- hclust(as.dist(e))

## plotting a dendrogram 
pdf(file = "dendrogram.pdf") 
hclustplot(hc.rd, k=3,cex=0.8)
dev.off()

## kmeans clustering for finding centers of each cluster
sub_grp <- cutree(hc.rd, k = 3)
table(sub_grp)
library(factoextra)
fviz_cluster(list(data = e, cluster = sub_grp), geom = "point",ellipse.type = "norm",show.clust.cent = TRUE)
km.res <- kmeans(e, 3, nstart = 10)

### finding representative of each cluster
library(FNN)
y <- get.knnx(e, km.res$centers, 1)
km.res$cluster[y$nn.index]

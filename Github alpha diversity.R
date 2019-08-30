library(Biostrings) 
library(ggplot2)
library(plyr)
library(stringr)
library(gridExtra)
library(reshape2)
library(knitr)
library(vegan)
library(DESeq2)
library(phyloseq)
library(scales)
library(ggthemes)
library(xlsx)
library(rJava)



setwd("D:/Data analysis in R/2016/Workspaces/M_final_files_for_r_HG0115")
load("HG0115_rarefied")


HG0115a = subset_samples(wt, Group%in%c("A", "B", "TN"))

sample_names(HG0115a)

set.seed(111)
HG0115a_rare = rarefy_even_depth(HG0115a, 29000) # rarefying again so all groups are together for plotting

HG0115a_rare_estimate = estimate_richness(HG0115a_rare)

alpha_HG0115a = cbind(sample_data(HG0115a_rare),HG0115a_rare_estimate)

sample_data(HG0115a_rare) = cbind(sample_data(HG0115a_rare),HG0115a_rare_estimate)

write.xlsx(alpha_HG0115a, "D:/Tables/HG0115/HG0115a_alpha.xlsx") # if you wish to export alpha diversity to excel

q<-plot_richness(HG0115a_rare, measures = c("Observed", "Shannon", "InvSimpson"), x = "DatePostInfection", color = "Dosed") + 
  geom_boxplot() + 
  geom_point() +
  labs(color="Dosed") +
  scale_colour_manual(breaks=c("RSV", "PBS", "TN"), labels=c("RSV", "PBS", "Naive"), values=c("hotpink3", "darkolivegreen4", "orange3")) +
  theme_base() +
  theme(strip.text.x = element_text(face = "bold", size=16)) +
  theme(axis.text = element_text(size = 12)) +
  theme(axis.title.x = element_blank()) +
  theme(axis.title.y = element_text(face = "bold", size = 14)) +
  theme(plot.background=element_blank())
q$layers <- q$layers[2]
q

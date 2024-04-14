# SUMMARY
# - analysis for fertilizer performance trials at Costa Farms during the summer of 2023
#
# - purpose was to find viable alternatives to the company's fertilizer standard
# 
# - this code gathered/organized data from excel, graphed important information, evaluated whether or not the fertilizers met standards,
#   and performed some statistical tests of difference using R
#
# - I am responsible for all of the code
#
# - note that any sensitive information has been given placeholder names
#
# POSSIBLE IMPROVEMENTS
# - this was specific to only a few trials we wanted to focus on..ideally with more time it would have been better to run this 
#   for all the trials at once and perform the statistical tests at every point
#
# - it would have been cool to do more data analysis... we ran some simple tests but there was a ton of data yet to be analyzed/compared...
#   the short time frame was a huge limiting factor

library("readxl")
read_excel("/Users/isaiah/Desktop/costa/Copia de Mandavillas Tracking FG.xlsx")
rm(list=ls())

#import sheets------

mtSheet <- read_excel("/Users/isaiah/Desktop/costa/Copia de Mandavillas Tracking FG.xlsx")
mainIDs <- read_excel("/Users/isaiah/Desktop/costa/Copia de Mandavillas Tracking FG.xlsx", sheet = "MainIDs")
heights <- read_excel("/Users/isaiah/Desktop/costa/Copia de Mandavillas Tracking FG.xlsx", sheet = "MeasureHeight")
pH <- read_excel("/Users/isaiah/Desktop/costa/Copia de Mandavillas Tracking FG.xlsx", sheet = "MeasurePh")
Ca <- read_excel("/Users/isaiah/Desktop/costa/Copia de Mandavillas Tracking FG.xlsx", sheet = "MeasureCa")
K <- read_excel("/Users/isaiah/Desktop/costa/Copia de Mandavillas Tracking FG.xlsx", sheet = "MeasureK")
NO3 <- read_excel("/Users/isaiah/Desktop/costa/Copia de Mandavillas Tracking FG.xlsx", sheet = "MeasureNO3")
EC <- read_excel("/Users/isaiah/Desktop/costa/Copia de Mandavillas Tracking FG.xlsx", sheet = "MeasureEC")
PC <- read_excel("/Users/isaiah/Desktop/costa/Copia de Mandavillas Tracking FG.xlsx", sheet = "PotCover")
  
#find main id's----
wo <- "9376" #------> ENTER LAST 4 OF WO
tNum <- 4    #------> ENTER NUMBER OF TREATMENTS
sw <- 24     #------> ENTER START WEEK
fw <- 28     #------> ENTER FINISH WEEK

id_list = vector()

for (i in 1:nrow(mtSheet)){
  if (grepl(wo, mainIDs[i, 3], fixed = TRUE))
    id_list = append(id_list, mainIDs[i,1])
}


#create empty data frames for measurements----
ht <- data.frame(T1=numeric(0),T2=numeric(0),T3=numeric(0),T4=numeric(0))
ph <- data.frame(T1=numeric(0),T2=numeric(0),T3=numeric(0),T4=numeric(0))
ca <- data.frame(T1=numeric(0),T2=numeric(0),T3=numeric(0),T4=numeric(0))
k <- data.frame(T1=numeric(0),T2=numeric(0),T3=numeric(0),T4=numeric(0))
no3 <- data.frame(T1=numeric(0),T2=numeric(0),T3=numeric(0),T4=numeric(0))
ec <- data.frame(T1=numeric(0),T2=numeric(0),T3=numeric(0),T4=numeric(0))
pc <- data.frame(T1=numeric(0),T2=numeric(0),T3=numeric(0),T4=numeric(0))

#variables for finding measurements----
rnum = 1
cnum = 1

#loop to get actual measurements in separate tables----
for(i in 1:length(id_list)){
  
  #find first index of ID
  htid = match(id_list[i],heights$Item)
  phid = match(id_list[i],pH$Item)
  caid = match(id_list[i],Ca$Item)
  kid = match(id_list[i],K$Item)
  no3id = match(id_list[i],NO3$Item)
  ecid = match(id_list[i],EC$Item)
  pcid = match(id_list[i],PC$Item)
  
  #find which treatment
  if(i%%4 == 0){cnum=4}
  else {cnum = i%%4}
  
  #find week and row number
  if(i%%tNum == 1 & i > tNum){
    rnum = rnum + 5
  }
  
  #append measurements
  for (j in 0:4){
    ht[rnum + j, cnum] = heights$Height[htid + j]
    ph[rnum + j, cnum] = pH$Ph[phid + j]
    ca[rnum + j, cnum] = Ca$Ca[caid + j]
    k[rnum + j, cnum] = K$K[kid + j]
    no3[rnum + j, cnum] = NO3$NO3[no3id + j]
    ec[rnum + j, cnum] = EC$EC[ecid + j]
    pc[rnum + j, cnum] = PC$Pot_Cover[pcid + j]
  }
  
}

#populate ca, k, no3 data added later for 9375, 9184, maybe 9139...


#GET WEEKLY AVERAGES----

#lists to loop through

listRaw = list(ht,ph,ca,k,no3,ec,pc)
listAvg = list()

#find averages
for (i in 1:length(listRaw)){
  
  #temp data
  dfRaw=as.data.frame(listRaw[i])
  dfAvg=data.frame(Week = c(25,26,27,28,29))
  
  #populate temp data
  for (j in 1:ncol(dfRaw)){
    avg1 = mean(dfRaw[,j][1:5])
    avg2 = mean(dfRaw[,j][6:10])
    avg3 = mean(dfRaw[,j][11:15])
    avg4 = mean(dfRaw[,j][16:20])
    avg5 = mean(dfRaw[,j][21:25])
    
    col = c(avg1, avg2, avg3, avg4, avg5)
    if(dfRaw[1,1]==53){print(col)}
    dfAvg <- cbind(dfAvg, col)
    if(dfRaw[1,1]==53){print(dfAvg)}
    
    colName <- paste("T",as.character(j), sep="")
    colnames(dfAvg)[j+1] <- colName
    

  }
  #add to permanent list
  listAvg <- append(listAvg, list(dfAvg))
}

#rename df's appropriately
names(listAvg) <- c("htAvg","phAvg","caAvg","kAvg","no3Avg","ecAvg","pcAvg")


#GRAPHING----
library("tidyverse")
library("greekLetters")
treatments <- c("Week", "NAME1", "NAME2", "NAME3", "NAME4")  #fertilizer names removed for confidentiality

#height
htAvg <- as.data.frame(listAvg[1])
colnames(htAvg) <- treatments
            
htGraph <- gather(htAvg, key = Treatment, value = Measure, NAME1, NAME2, NAME3, NAME4,) %>%
  ggplot(aes(x = Week, y = Measure, group = Treatment, colour = Treatment)) + 
  geom_line(size = 1.5) + geom_point(size = 2) +
  labs(y = "Plant Height (in)", title = "Average Height vs Week") +
  annotate('rect',xmin=25,xmax=29,ymin=5,ymax=7,alpha=.2,fill='red') +
  annotate('text',x=27,y=6,label = "Target Region", size = 5, fontface = "bold") +
  annotate('text',x=29.1,y=5,label = "5") +
  annotate('text',x=29.1,y=7,label = "7") +
  theme_grey(base_size=15)
htGraph

#ph
phAvg <- as.data.frame(listAvg[2])
colnames(phAvg) <- treatments

phGraph <- gather(phAvg, key = Treatment, value = Measure, NAME1, NAME2, NAME3, NAME4,) %>%
  ggplot(aes(x = Week, y = Measure, group = Treatment, colour = Treatment)) + 
  geom_line(size = 1.5) + geom_point(size = 2) +
  labs(y = "pH", title = "Average pH vs Week") +
  theme_grey(base_size=15) +
  annotate('rect',xmin=25,xmax=29,ymin=5.4,ymax=5.8,alpha=.2,fill='red') +
  annotate('text',x=27,y=5.6,label = "Target Region", size = 5, fontface = "bold") +
  annotate('text',x=29.1,y=5.4,label = "5.4") +
  annotate('text',x=29.1,y=5.8,label = "5.8")
phGraph

#ec
ecAvg <- as.data.frame(listAvg[6])
colnames(ecAvg) <- treatments

ecGraph <- gather(ecAvg, key = Treatment, value = Measure, NAME1, NAME2, NAME3, NAME4,) %>%
  ggplot(aes(x = Week, y = Measure, group = Treatment, colour = Treatment)) + 
  geom_line(size = 1.5) + geom_point(size = 2) +
  labs(y = paste("EC (dS/m)", sep = ""), title = "Average EC vs Week") +
  theme_grey(base_size=15) +
  annotate('rect',xmin=25,xmax=29,ymin=1.0,ymax=2.6,alpha=.2,fill='red') +
  annotate('text',x=27,y=1.8,label = "Target Region", size = 5, fontface = "bold") +
  annotate('text',x=29.1,y=1.0,label = "1.0") +
  annotate('text',x=29.1,y=2.6,label = "2.6")
ecGraph

#pc
pcAvg <- as.data.frame(listAvg[7])
colnames(pcAvg) <- treatments

pcGraph <- gather(pcAvg, key = Treatment, value = Measure, NAME1, NAME2, NAME3, NAME4,) %>%
  ggplot(aes(x = Week, y = Measure, group = Treatment, colour = Treatment)) + 
  geom_line(size = 1.5) + geom_point(size = 2) +
  labs(y = "Pot Coverage (%)", title = "Average Pot Coverage vs Week") +
  theme_grey(base_size=15)
pcGraph


#STATS FOR EC - 9375, 9184 T2----

#Assumptions:
#independent
#equal variances

#normality tests
shapiro.test(ec$T1[11:15])
shapiro.test(ec$T2[11:15])
shapiro.test(ec$T3[11:15])
shapiro.test(ec$T4[11:15])

#Anova/Kruskal
ecAnova <- gather(ec[11:15,], key = Treatment, value = Measure, T1, T2, T3, T4)
kruTest <- kruskal.test(Measure ~ Treatment, data = ecAnova)
aovTest <- aov(Measure ~ Treatment, data = ecAnova)
kruTest
summary(aovTest)

#wilcox tests for sig diff against T3
wilcox.test(ec$T3[11:15], ec$T1[11:15])
wilcox.test(ec$T3[11:15], ec$T2[11:15])
wilcox.test(ec$T3[11:15], ec$T4[11:15])

#lichen prediction based on landsat 5 and 8
#NFI data taken from Ulrikas project
#Sven Adler
#2020-08-04



##################################################
#1987

library(raster)
library(sp)
library(rgdal)
scene_list<-dir(path="C:/satellite_data",pattern=".tif",full.names = TRUE)

projRT90 <- "+init=epsg:3021 +towgs84=414.0978567149,41.3381489658,603.0627177516,-0.8550434314,2.1413465,-7.0227209516,0 +no_defs"
projSWEREF <- "+init=epsg:3006"



b1<-raster("C:/satellite_data/b1_north_sweden_1987.tif")
b2<-raster("C:/satellite_data/b2_north_sweden_1987.tif")
b3<-raster("C:/satellite_data/b3_north_sweden_1987.tif")
b4<-raster("C:/satellite_data/b4_north_sweden_1987.tif")
b5<-raster("C:/satellite_data/b5_north_sweden_1987.tif")
b6<-raster("C:/satellite_data/b6_north_sweden_1987.tif")
b7<-raster("C:/satellite_data/b7_north_sweden_1987.tif")


library(dplyr)
taxdata<-readRDS("D:/Gaste/Ulrika Roos/trainings_data.rds")
tax80<-taxdata %>% filter(Taxar%in%c(1983:1987)) %>% 
  mutate(Tackningsarea1=ifelse(is.na(Tackningsarea1),0,Tackningsarea1))

tax80.sp<-SpatialPointsDataFrame(coords=tax80[,c("Ostkoordinat","Nordkoordinat")],data=tax80,proj4string=CRS(projSWEREF))

plot(tax80$Ostkoordinat,tax80$Nordkoordinat) 




e1<-extent(b1)
e1
tax.sp<-crop(tax80.sp,e1)

tax.sp$b1<-extract(b1,tax.sp)
tax.sp$b2<-extract(b2,tax.sp)
tax.sp$b3<-extract(b3,tax.sp)
tax.sp$b4<-extract(b4,tax.sp)
tax.sp$b5<-extract(b5,tax.sp)
tax.sp$b6<-extract(b6,tax.sp)
tax.sp$b7<-extract(b7,tax.sp)

wetness<-raster("C:/wetness/wetness_swe_complete.tif")
tax.sp$wetness<-extract(wetness,tax.sp)


library(mgcv)
fit80<-gam(renlav/100~#s(b1)
           #+s(b2)
           s(b3)
           +s(b4)
           +s(b5)
           +s(b6)
           +s(b7)
           +s(wetness)
           ,data=tax.sp,"quasibinomial")
summary(fit80)
gam.check(fit80)
plot(fit80,pages=1,scale=F)
#->malo shape
#->perdiction
#
sameby<-readOGR("C:/Users/Public/Documents/RenGIS/iRenMark/LstGIS.2018-02-19/Samebyarnas betesområden","IRENMARK_DBO_sameby")
sameby<-spTransform(sameby,CRS=projSWEREF)
#sb<-subset(sameby,NAMN=="MalÃ¥")
#sb<-subset(sameby,NAMN=="Mausjaur")
#sb<-subset(sameby,NAMN=="Baste")
sb<-subset(sameby,NAMN=="Vilhelmina norra")
library(mapview)
mapview(sb)
e1<-extent(sb)


#plot(sb)
#plot(b1)

#e1<-drawExtent()



b1<-raster("C:/satellite_data/b1_north_sweden_1987.tif")
b2<-raster("C:/satellite_data/b2_north_sweden_1987.tif")
b3<-raster("C:/satellite_data/b3_north_sweden_1987.tif")
b4<-raster("C:/satellite_data/b4_north_sweden_1987.tif")
b5<-raster("C:/satellite_data/b5_north_sweden_1987.tif")
b6<-raster("C:/satellite_data/b6_north_sweden_1987.tif")
b7<-raster("C:/satellite_data/b7_north_sweden_1987.tif")




b1_c<-crop(b1,e1)
b2_c<-crop(b2,e1)
b3_c<-crop(b3,e1)
b4_c<-crop(b4,e1)
b5_c<-crop(b5,e1)
b6_c<-crop(b6,e1)
b7_c<-crop(b7,e1)
wetness1<-crop(wetness,e1)
#wetness1<-aggregate(wetness,fact=3)

wetness<-resample(wetness1,b1_c,methpd="ngb")
wetness_c<-crop(wetness,e1)



bs <- blockSize(b1_c,minblocks = 4000)
out<-b1_c
out1 <- writeStart(out, "D:/temp_raster/test1.grd", overwrite=TRUE)

for (i in 1:bs$n)
{
  
  b1<- getValues(b1_c, row=bs$row[i], nrows=bs$nrows[i] )
  b2<- getValues(b2_c, row=bs$row[i], nrows=bs$nrows[i] )
  b3<- getValues(b3_c, row=bs$row[i], nrows=bs$nrows[i] )
  b4<- getValues(b4_c, row=bs$row[i], nrows=bs$nrows[i] )
  b5<- getValues(b5_c, row=bs$row[i], nrows=bs$nrows[i] )
  b6<- getValues(b6_c, row=bs$row[i], nrows=bs$nrows[i] )
  b7<- getValues(b7_c, row=bs$row[i], nrows=bs$nrows[i] )
  wetness<- getValues(wetness_c, row=bs$row[i], nrows=bs$nrows[i] )
 
 
  
  data.p<-data.frame(b1
                      ,b2
                      ,b3
                      ,b4
                      ,b5
                      ,b6
                      ,b7
                     ,wetness
                     )
  t1<-predict(fit80,data.p,type="response")
  out1 <- writeValues(out1, t1, bs$row[i])
}

out1 <- writeStop(out1)
lav.pred<-out1
#writeRaster(lav.pred,file="D:/UMEA/Renbruksplan/lichenmap_1980_2010/malo87_all80.tif",format="GTiff",overwrite=T)
#writeRaster(lav.pred,file="D:/UMEA/Renbruksplan/lichenmap_1980_2010/mausjaure87_all80.tif",format="GTiff",overwrite=T)
writeRaster(lav.pred,file="D:/UMEA/Renbruksplan/lichenmap_1980_2010/vilhelmina_norr87_all80.tif",format="GTiff",overwrite=T)

# b1.p<-b1
# b1<-getValues(b1)
# b2<-getValues(b2)
# b3<-getValues(b3)
# b4<-getValues(b4)
# b5<-getValues(b5)
# b6<-getValues(b6)
# b7<-getValues(b7)
# wetness<-getValues(wetness)
# 
# data.p<-data.frame(b1,b2,b3,b4,b5,b6,b7,wetness)
# 
# pred.lav<-predict(fit80,data.p,type="response")
# 
# lav.pred<-setValues(b1.p,as.vector(pred.lav))
# writeRaster(lav.pred,file="D:/UMEA/Renbruksplan/lichenmap_1980_2010/malo87_V1w.tif",format="GTiff",overwrite=T)
# 
# 
# lav.pred.re<-resample(lav.pred,nmd_e,methpd="ngb")
# 
#set nyr,vatten, vägar NA


lav.pred<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/vilhelmina_norr87_all80.tif")
nmd<-raster("D:/UMEA/NMD-nya SMD/NMD/nmd2018bas_ogeneraliserad_v1_0.tif")
e1<-extent(lav.pred)
nmd_e<-crop(nmd,e1)

lav.pred.re<-resample(lav.pred,nmd_e,methpd="ngb")
lav.val<-getValues(lav.pred.re)
nmd.val<-getValues(nmd_e)
lav.val<-ifelse(nmd.val==2,NA,lav.val)
lav.val<-ifelse(nmd.val==3,NA,lav.val)
lav.val<-ifelse(nmd.val==4,NA,lav.val) 
lav.val<-ifelse(nmd.val==41,NA,lav.val)
lav.val<-ifelse(nmd.val==42,NA,lav.val)
lav.val<-ifelse(nmd.val==5,NA,lav.val)
lav.val<-ifelse(nmd.val==51,NA,lav.val)
lav.val<-ifelse(nmd.val==52,NA,lav.val)
lav.val<-ifelse(nmd.val==53,NA,lav.val)
lav.val<-ifelse(nmd.val==6,NA,lav.val)
lav.val<-ifelse(nmd.val==61,NA,lav.val)
lav.val<-ifelse(nmd.val==62,NA,lav.val)
lav.val<-ifelse(lav.val>70,70,lav.val)
lav.val<-ifelse(lav.val<0,0,lav.val)
lav.pred<-setValues(lav.pred.re,lav.val)
#writeRaster(lav.pred,file="D:/UMEA/Renbruksplan/lichenmap_1980_2010/malo87_all80nmd.tif",format="GTiff",overwrite=T)
writeRaster(lav.pred,file="D:/UMEA/Renbruksplan/lichenmap_1980_2010/vilhelmina_norr87_all80nmd.tif",format="GTiff",overwrite=T)








lav.val<-getValues(lav.pred)
lav.val<-round(lav.val*100,0)
lav.val.temp<-lav.val
lav.val.temp<-ifelse(lav.val%in%c(0:10),1,lav.val.temp)
lav.val.temp<-ifelse(lav.val%in%c(10:25),2,lav.val.temp)
lav.val.temp<-ifelse(lav.val%in%c(25:50),3,lav.val.temp)
lav.val.temp<-ifelse(lav.val%in%c(50:100),4,lav.val.temp)
unique(lav.val.temp)
#prop.table(table(lav.val.temp))
lav.pred.class<-setValues(lav.pred.re,lav.val.temp)
writeRaster(lav.pred.class,file="D:/UMEA/Renbruksplan/lichenmap_1980_2010/vilhelmina_norr87_all80nmd_4classes.tif",format="GTiff",overwrite=T)







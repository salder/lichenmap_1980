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
rasterOptions(tmpdir="L:/temp_raster/")
#rasterOptions(tmpdir="C:/TEMP/")

# b1<-raster("C:/satellite_data/b1_north_sweden_1987.tif")
# b2<-raster("C:/satellite_data/b2_north_sweden_1987.tif")
# b3<-raster("C:/satellite_data/b3_north_sweden_1987.tif")
# b4<-raster("C:/satellite_data/b4_north_sweden_1987.tif")
# b5<-raster("C:/satellite_data/b5_north_sweden_1987.tif")
# b6<-raster("C:/satellite_data/b6_north_sweden_1987.tif")
# b7<-raster("C:/satellite_data/b7_north_sweden_1987.tif")

# b1a<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b1_north_sweden_1987-0000000000-0000000000.tif")
# b1b<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b1_north_sweden_1987-0000065536-0000000000.tif")
# b1<-merge(b1a,b1b)
# writeRaster(b1,file="D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b1_1987.tif",format="GTiff",overwrite=T)
# 
# 
# b2a<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b2_north_sweden_1987-0000000000-0000000000.tif")
# b2b<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b2_north_sweden_1987-0000065536-0000000000.tif")
# b2<-merge(b2a,b2b)
# writeRaster(b2,file="D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b2_1987.tif",format="GTiff",overwrite=T)
# 
# b3a<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b3_north_sweden_1987-0000000000-0000000000.tif")
# b3b<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b3_north_sweden_1987-0000065536-0000000000.tif")
# b3<-merge(b3a,b3b)
# writeRaster(b3,file="D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b3_1987.tif",format="GTiff",overwrite=T)
# 
# b4a<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b4_north_sweden_1987-0000000000-0000000000.tif")
# b4b<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b4_north_sweden_1987-0000065536-0000000000.tif")
# b4<-merge(b4a,b4b)
# writeRaster(b4,file="D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b4_1987.tif",format="GTiff",overwrite=T)
# 
# b5a<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b5_north_sweden_1987-0000000000-0000000000.tif")
# b5b<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b5_north_sweden_1987-0000065536-0000000000.tif")
# b5<-merge(b5a,b5b)
# writeRaster(b5,file="D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b5_1987.tif",format="GTiff",overwrite=T)
# 
# b6a<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b6_north_sweden_1987-0000000000-0000000000.tif")
# b6b<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b6_north_sweden_1987-0000065536-0000000000.tif")
# b6<-merge(b6a,b6b)
# writeRaster(b6,file="D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b6_1987.tif",format="GTiff",overwrite=T)
# 
# 
# b7a<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b7_north_sweden_1987-0000000000-0000000000.tif")
# b7b<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b7_north_sweden_1987-0000065536-0000000000.tif")
# b7<-merge(b7a,b7b)
# writeRaster(b7,file="D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b7_1987.tif",format="GTiff",overwrite=T)





b1<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b1_1987.tif")
b2<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b2_1987.tif")
b3<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b3_1987.tif")
b4<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b4_1987.tif")
b5<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b5_1987.tif")
b6<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b6_1987.tif")
b7<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b7_1987.tif")







library(dplyr)
taxdata<-readRDS("D:/Gaste/Ulrika Roos/trainings_data.rds")
tax80<-taxdata %>% filter(Taxar%in%c(1983:1987)) %>% 
  filter(!is.na(Tackningsarea1)) #  neu 2022-03-21
  #mutate(Tackningsarea1=ifelse(is.na(Tackningsarea1),0,Tackningsarea1))

tax80.sp<-SpatialPointsDataFrame(coords=tax80[,c("Ostkoordinat","Nordkoordinat")],data=tax80,proj4string=CRS(projSWEREF))

#plot(tax80$Ostkoordinat,tax80$Nordkoordinat) 




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
tax.sp$ndvi<-(tax.sp$b4-tax.sp$b3)/(tax.sp$b4+tax.sp$b3)

wetness<-raster("L:/wetness/wetness_swe_complete.tif")
tax.sp$wetness<-extract(wetness,tax.sp)

tax_sub.sp<-subset(tax.sp, tax.sp$renlav<101)
tax_sub.sp<-subset(tax_sub.sp, !is.na(tax_sub.sp$wetness))
tax_sub.sp<-subset(tax_sub.sp, !is.na(tax_sub.sp$ndvi))
library(mgcv)
fit80<-gam(renlav/100~#s(b1)
           #+s(b2)
           +s(Ostkoordinat)+s(Nordkoordinat)
            # +s(b3)
           #+s(b4)
           +s(b5)
           +s(b6)
           +s(b7)
           +s(ndvi)
           +s(wetness)
           ,data=tax_sub.sp,"quasibinomial")
summary(fit80)
gam.check(fit80)
plot(fit80,pages=1,scale=F)


tax_sub.sp$predicted_mod1<-predict(fit80,type="response")

tax_sub.sp$dif<-tax_sub.sp$renlav/100-tax_sub.sp$predicted_mod1

tax_sub.sp$dif_ind<-ifelse(abs(tax_sub.sp$renlav/100-tax_sub.sp$dif)>tax_sub.sp$renlav/100*0.4,0,1)


tax_sub_dif.sp<-subset(tax_sub.sp,tax_sub.sp$dif_ind==1)



fit80j<-gam(renlav/100~#s(b1)
             +s(b2)
             +s(Ostkoordinat)+s(Nordkoordinat)
           # +s(b3)
           #+s(b4)
           +s(b5)
           +s(b6)
           +s(b7)
           +s(ndvi)
           +s(wetness)
           ,data=tax_sub_dif.sp,"quasibinomial")
summary(fit80j)
gam.check(fit80j)
plot(fit80j,pages=1,scale=F)




#->malo shape
#->perdiction
#
sameby<-readOGR("C:/Users/Public/Documents/RenGIS/iRenMark/LstGIS.2018-02-19/Samebyarnas betesområden","IRENMARK_DBO_sameby")
sameby<-spTransform(sameby,CRS=projSWEREF)
#sb<-subset(sameby,NAMN=="MalÃ¥")
#sb<-subset(sameby,NAMN=="Mausjaur")
#sb<-subset(sameby,NAMN=="Baste")
sb<-subset(sameby,NAMN=="Vilhelmina norra")
sb<-subset(sameby,NAMN=="Gran")
sb<-subset(sameby,NAMN=="Luokta-Mávas")
sb<-subset(sameby,NAMN=="Maskaure")
sb<-subset(sameby,NAMN=="Maskaure")

library(mapview)
mapview(sb)
plot(sb)
e1<-extent(sb)
e1<-drawExtent()
#maskaure kust delen! 
#e1<-extent(714142.8,827380.4,7143802 ,7226198 ) 

#plot(sb)
#plot(e1,add=T)
#plot(b1)

#e1<-drawExtent()



# b1<-raster("C:/satellite_data/b1_north_sweden_1987.tif")
# b2<-raster("C:/satellite_data/b2_north_sweden_1987.tif")
# b3<-raster("C:/satellite_data/b3_north_sweden_1987.tif")
# b4<-raster("C:/satellite_data/b4_north_sweden_1987.tif")
# b5<-raster("C:/satellite_data/b5_north_sweden_1987.tif")
# b6<-raster("C:/satellite_data/b6_north_sweden_1987.tif")
# b7<-raster("C:/satellite_data/b7_north_sweden_1987.tif")




b1<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b1_1987.tif")
b2<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b2_1987.tif")
b3<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b3_1987.tif")
b4<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b4_1987.tif")
b5<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b5_1987.tif")
b6<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b6_1987.tif")
b7<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data/b7_1987.tif")
#for the holw area:
#e1<-extent(b1)
#lichen_base_map<-raster("D:/UMEA/Renbruksplan/Lavprojekt_2019/lichenmodel.tif")
#e1<-extent(lichen_base_map)
#plot(b2)
#plot(e1,add=T)


b1_c<-crop(b1,e1)
b2_c<-crop(b2,e1)
b3_c<-crop(b3,e1)
b4_c<-crop(b4,e1)
b5_c<-crop(b5,e1)
b6_c<-crop(b6,e1)
b7_c<-crop(b7,e1)
wetness1<-crop(wetness,e1)
#wetness1<-aggregate(wetness,fact=3)

#wetness<-resample(wetness1,b1_c,methpd="ngb")
#wetness_c<-crop(wetness,e1)



bs <- blockSize(b1_c,minblocks = 2000)
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
  wetness<- getValues(wetness1, row=bs$row[i], nrows=bs$nrows[i] )
 
 
  
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
writeRaster(lav.pred,file="D:/UMEA/Renbruksplan/lichenmap_1980_2010/Luokta_M_87_all.tif",format="GTiff",overwrite=T)

lav.pred100<-round(lav.pred*100,0)
writeRaster(lav.pred100,file="D:/UMEA/Renbruksplan/lichenmap_1980_2010/Luokta_M_87_all100.tif",format="GTiff",overwrite=T)
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


lav.pred<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/Luokta_M_87_all100.tif")
lichen_base_map<-raster("D:/UMEA/Renbruksplan/Lavprojekt_2019/lichenmodel.tif")
#sb<-readOGR("D:/UMEA/Renbruksplan/Nobel/Vardostb_J","RE Vardostb")
#e1<-extent(sb)
lichen_base_map<-crop(lichen_base_map,e1)

lichen_base_map<-mask(lichen_base_map,sb)
writeRaster(lichen_base_map,file="D:/UMEA/Renbruksplan/lichenmap_1980_2010/Luokta_M_today_base_map.tif",format="GTiff",overwrite=T)
#Vardostb<-readOGR("D:/UMEA/Renbruksplan/Nobel/Vardostb_J","RE Vardostb")
plot(lichen_base_map)
#plot(Vardostb,add=T)
#lichen_base_map<-mask(lichen_base_map,Vardostb)
#e2<-extent(Vardostb)
#lichen_base_map<-crop(lichen_base_map,e2)
#writeRaster(lichen_base_map,file="D:/UMEA/Renbruksplan/lichenmap_1980_2010/Vardostb_lichen_today.tif",format="GTiff",overwrite=T)


e1<-extent(lichen_base_map)
lav.pred<-crop(lav.pred,e1)



bs <- blockSize(lav.pred,minblocks = 600)
out<-lav.pred
out1 <- writeStart(out, "D:/temp_raster/test1.grd", overwrite=TRUE)

for (i in 1:bs$n)
{
  
  lav80<- getValues(lav.pred, row=bs$row[i], nrows=bs$nrows[i] )#*100
  lav80<-round(lav80,0)
  lav80<-ifelse(lav80>70,70,lav80)
  #lav80<-ifelse(lav80<20,0,lav80)
  lavny<- getValues(lichen_base_map, row=bs$row[i], nrows=bs$nrows[i] )
  
  t1<-ifelse(is.na(lavny),NA,lav80)
  out1 <- writeValues(out1, t1, bs$row[i])
}

out1 <- writeStop(out1)
lav.pred<-out1
#writeRaster(lav.pred,file="D:/UMEA/Renbruksplan/lichenmap_1980_2010/malo87_all80.tif",format="GTiff",overwrite=T)
#writeRaster(lav.pred,file="D:/UMEA/Renbruksplan/lichenmap_1980_2010/mausjaure87_all80.tif",format="GTiff",overwrite=T)
writeRaster(lav.pred,file="D:/UMEA/Renbruksplan/lichenmap_1980_2010/Luokta_M_87_all_mask_0.tif",format="GTiff",overwrite=T)









# 
# 
# nmd<-raster("D:/UMEA/NMD-nya SMD/NMD/nmd2018bas_ogeneraliserad_v1_0.tif")
# e1<-extent(lav.pred)
# nmd_e<-crop(nmd,e1)
# 
# lav.pred.re<-resample(lav.pred,nmd_e,methpd="ngb")
# lav.val<-getValues(lav.pred.re)
# nmd.val<-getValues(nmd_e)
# lav.val<-ifelse(nmd.val==2,NA,lav.val)
# lav.val<-ifelse(nmd.val==3,NA,lav.val)
# lav.val<-ifelse(nmd.val==4,NA,lav.val) 
# lav.val<-ifelse(nmd.val==41,NA,lav.val)
# lav.val<-ifelse(nmd.val==42,NA,lav.val)
# lav.val<-ifelse(nmd.val==5,NA,lav.val)
# lav.val<-ifelse(nmd.val==51,NA,lav.val)
# lav.val<-ifelse(nmd.val==52,NA,lav.val)
# lav.val<-ifelse(nmd.val==53,NA,lav.val)
# lav.val<-ifelse(nmd.val==6,NA,lav.val)
# lav.val<-ifelse(nmd.val==61,NA,lav.val)
# lav.val<-ifelse(nmd.val==62,NA,lav.val)
# lav.val<-ifelse(lav.val>70,70,lav.val)
# lav.val<-ifelse(lav.val<0,0,lav.val)
# lav.pred<-setValues(lav.pred.re,lav.val)
# #writeRaster(lav.pred,file="D:/UMEA/Renbruksplan/lichenmap_1980_2010/malo87_all80nmd.tif",format="GTiff",overwrite=T)
# writeRaster(lav.pred,file="D:/UMEA/Renbruksplan/lichenmap_1980_2010/vilhelmina_norr87_all80nmd.tif",format="GTiff",overwrite=T)
# 
# 
# 
# 
# 
# 
# 
# 
# lav.val<-getValues(lav.pred)
# lav.val<-round(lav.val*100,0)
# lav.val.temp<-lav.val
# lav.val.temp<-ifelse(lav.val%in%c(0:10),1,lav.val.temp)
# lav.val.temp<-ifelse(lav.val%in%c(10:25),2,lav.val.temp)
# lav.val.temp<-ifelse(lav.val%in%c(25:50),3,lav.val.temp)
# lav.val.temp<-ifelse(lav.val%in%c(50:100),4,lav.val.temp)
# unique(lav.val.temp)
# #prop.table(table(lav.val.temp))
# lav.pred.class<-setValues(lav.pred.re,lav.val.temp)
# writeRaster(lav.pred.class,file="D:/UMEA/Renbruksplan/lichenmap_1980_2010/vilhelmina_norr87_all80nmd_4classes.tif",format="GTiff",overwrite=T)
# 
# 
# 
# 
# 
#######################################################################################################################
library(raster)
lav.pred<-raster("D:/UMEA/Renbruksplan/lichenmap_1980_2010/vilhelmina_norr87_all80.tif")
 lav.val<-getValues(lav.pred)
 lav.val<-round(lav.val*100,0)
 lav.val.temp<-lav.val
 lav.val.temp<-ifelse(lav.val%in%c(0:12),1,lav.val.temp) #klasser kommer från PER
 lav.val.temp<-ifelse(lav.val%in%c(12:20),2,lav.val.temp)
 lav.val.temp<-ifelse(lav.val%in%c(20:35),3,lav.val.temp)
 lav.val.temp<-ifelse(lav.val%in%c(35:150),4,lav.val.temp)
 unique(lav.val.temp)
 #prop.table(table(lav.val.temp))
 lav.pred.class<-setValues(lav.pred,lav.val.temp)
 writeRaster(lav.pred.class,file="D:/UMEA/Renbruksplan/lichenmap_1980_2010/vilhelmina_norr87_all80nmd_4classes_per.tif",format="GTiff",overwrite=T)
# 

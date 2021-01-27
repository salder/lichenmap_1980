library(googledrive)
drive_find()    #chose0 
#satellit images

setwd("D:/UMEA/Renbruksplan/lichenmap_1980_2010/satellite_data")
 #choose "2"
t1<-drive_find()
files<-grep("1987",t1$name,value=TRUE)

for (i in 1:length(files))
  drive_download(file=files[i],overwrite=TRUE)


scene_list<-dir(path="M:/THUF-Fjall/GEE-Harjedalen",pattern=".tif",full.names = TRUE)




parameter_list<-c(
  "ndwi_m7_8"
  ,"ndwi_m5_6"
  ,"b1_m7_8"
  ,"b2_m7_8"
  ,"b3_m7_8"
  ,"b4_m7_8"
  ,"b5_m7_8"
  ,"b6_m7_8"
  ,"b7_m7_8"
  ,"b8_m7_8"
  ,"b9_m7_8"
  ,"b10_m7_8"
  ,"b11_m7_8"
  
  ,"b1_m5_6"
  ,"b2_m5_6"
  ,"b3_m5_6"
  ,"b4_m5_6"
  ,"b5_m5_6"
  ,"b6_m5_6"
  ,"b7_m5_6"
  ,"b8_m5_6"
  ,"b9_m5_6"
  ,"b10_m5_6"
  ,"b11_m5_6"
  ,"ndvi_m5_6"
  ,"ndvi_m7_8"
  ,"ndwi_land_clip_m5_6"
  ,"ndwi_land_clip_m7_8"
  ,"soil_m5_6"
  ,"soil_m7_8"
  #,
)

for (k in 16:length(parameter_list))
{                  
  
  parameter<-parameter_list[k]
  #parameter="ndwi_m7_8"
  scene_list_red<-grep(parameter,scene_list,value = TRUE)
  file.copy(from=scene_list_red, to="F:/Geo-Data/temp_calc/",overwrite=TRUE)
  scene_list_red<-dir(path="F:/Geo-Data/temp_calc/",pattern=".tif",full.names = TRUE)
  
  k1<-raster(scene_list_red[1])   
  k2<-raster(scene_list_red[2])  
  
  test_m<-list(k1,k2)
  
  if (length(scene_list_red)>2)
  {
    for (i in (3):length(scene_list_red))
    {
      k3<-raster(scene_list_red[i])
      test_m<-append(test_m,k3)
    }
  }
  
  test_m$filename <-"F:/Geo-Data/try1.tif"
  test_m$overwrite <- TRUE
  mm <- do.call(merge, test_m)
  projection(mm)<-projSWEREF
  #mm_1<-crop(mm,extent(alp))
  #mm_1<-mask(mm_1,alp)
  file_name<-paste("F:/Härjedalen/Geo-Data/",parameter,".tif", sep="")
  #file_name<-paste("F:/THUF/Fjäll-habitat-modell/Geo-data/",parameter,"_alp.tif", sep="")
  writeRaster(mm, filename=file_name, format="GTiff", overwrite=TRUE)
  file.remove(scene_list_red)
}

# laser files 
veg_cover<-function(Z,min=0.05)
{
  l<-length(Z)
  l_over<-sum(ifelse(Z>=min,1,0))
  cover<-l_over/l
  return(cover)
}



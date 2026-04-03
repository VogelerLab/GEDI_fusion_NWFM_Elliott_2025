#This script makes the ebird data file (spp_data.csv) for each of the individual species of interest 

script_dir <- "C:/Users/lisah/Documents/GEDI Work/Analysis files/Data Prep"
#source(file.path(script_dir, "spatialDataDownload.R")) #if you need to download new versions of the GEDI-fusion data
spp <- c("piwo", "nofl", "dowo", "whwo", "hawo", "lewo", "wisa", "rbsa",
         "attw", "rnsa", "bbwo", "acwo")
cname <- c("Pileated Woodpecker", "Northern Flicker", "Downy Woodpecker",
           "White-headed Woodpecker","Hairy Woodpecker", 
           "Lewis's Woodpecker", "Williamson's Sapsucker", 
           "Red-breasted Sapsucker", "American Three-toed Woodpecker",
           "Red-naped Sapsucker", "Black-backed Woodpecker", "Acorn Woodpecker")
gedi <- c("global")
rm_list <- c("script_dir", "spp", "sp", "detection_freq", "train_name", "test_name",
             "ebdname", "ename", "fname", "basedir", "xname", "psname", "filname",
             "det_table", "det_table_sampled", "detection_freq", "mod", "gedi", "m")
for(m in 1:length(gedi)){
  if(gedi[m]=="global"){
    mod <- c("_s1_dist_")
  } else {
    mod <- c("_")
  }}

for(p in 1:length(spp)){
  print(spp[p])
  sp <- spp[p]
  cn <- cname[p]
  fname <- paste0("ebird/ebd_", sp, "_spr20162020_fullStudyArea_zf.csv")
  ename <- paste0("~/GEDI Work/data/", sp, "_data.csv")
  sfname <- paste0("~/GEDI Work/data/", sp, "_sf.csv")
  map_name <- paste0("maps/", sp, "_map.png")
  dname <- paste0(sp, "_data.csv")
  mname <- paste0("data/modis_pland_location-year_", sp, "_hotspot.csv")
  xname <- paste0("data/pland-elev_location-year_", sp, "_hotspot.csv")
  psname <- paste0("data/pland-elev_prediction-surface_", sp, "_hotspot.csv")
  ebdname <- paste0("ebird/ebd_", sp, "_spr20162020_fullStudyArea_zf.csv")
  #fname <- paste0(substr(unique(ebird$state_code)[s], 4,5),"_topo_", 
  #              topoVars[v], "c.tif")
  #checkName <- paste0(spatialdir, "/", topoVars[v], "_", substr(unique(ebird$state_code)[s], 4,5), "_", sp, ".csv")
  #fname <- paste0(spatialdir, "/", topoVars[v], "_", substr(unique(ebird$state_code)[s], 4,5), "_", sp, ".csv")
  #fname <- paste0(spatialdir, "/", otherVars[o], "_", substr(unique(ebird$state_code)[s], 4,5), 
  #substr(unique(ebird$year)[y], 3,4), "_", sp, ".csv")
  #filname <- paste0(basedir, "/data/covariates_v2_", sp, ".csv")
  basedir <- "C:/Users/lisah/Documents/GEDI Work"
  spatialdir <- file.path(basedir, "data/spatial data_v2_w")
  fname <- paste0(basedir, "/data/", sp, "covs_v2_", gedi[m], ".csv")
  map_name <- paste0(sp, "_subsample_map.jpg")
  train_name <- paste0(sp, "_train_v2_", gedi[m], ".csv")
  test_name <-  paste0(sp, "_test_v2_", gedi[m], ".csv") 
  
  
  source(file.path(script_dir, "GISDataLayers_v2_w.R")) #make the ebird_sf file that doesn't save
  source(file.path(script_dir, "ebird data viz_map_v2_w_hotspot.R")) #make SPP_data.csv
}    

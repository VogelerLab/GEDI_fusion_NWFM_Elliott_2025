rng <- vect(paste0("D:/range maps/", sp, "_rng_", ecoregion, ".shp"))

spDat_proj <- spDat %>% 
  distinct(locality_id, latitude, longitude) %>%
  # convert to spatial features
  st_as_sf(coords = c("longitude", "latitude"), crs = 4326) %>% 
  # transform to projection of raster
  st_transform(crs = crs(rng))

extr <- extract(rng, vect(spDat_proj))



rng_proj <- project(rng, spp_richness)

rng_rst <- rasterize(rng_proj, spp_richness, 
                     background = 0,
                     field = 1)
rng_rst <- mask(rng_rst, spp_richness)



# Load the required libraries
library(terra)

#The species and ecoregion:
sp_list <- c("piwo", "nofl", "dowo", "whwo", "hawo", "lewo", "wisa", 
             "rbsa", "attw", "rnsa", "bbwo", "acwo")
ecoregion <- "nwmf"

for(sp in 1:length(sp_list)){
  print(sp_list[sp])
  # Read the shapefile (replace 'path/to/shapefile.shp' with the actual path)
  #shapefile <- vect('path/to/shapefile.shp')
  rng <- vect(paste0("D:/range maps/", sp_list[sp], "_rng_", ecoregion, ".shp"))

# Read the data frame (replace 'path/to/data.csv' with the actual path)
# Assume the data frame has columns 'latitude' and 'longitude'
  data <- read.csv(paste0("D:/hotspot/obs_", sp_list[sp], "_", ecoregion, ".csv"))
  bird_data <- read.csv(paste0("D:/hotspot/obs_", sp_list[sp], "_", ecoregion, ".csv"))

  # Convert the data frame to a SpatVector
  # Note: terra does not have a direct function to create a SpatVector from data frames,
  # so we need to create a temporary SpatRaster and convert it.
  data_spat <- vect(data, geom = c("longitude", "latitude"), crs = "EPSG:4326")
  
  # Ensure the shapefile and data frame use the same CRS
  shapefile_crs <- crs(rng)
  data_spat <- project(data_spat, shapefile_crs)
  
  # Clip the data frame to the shapefile's polygons
  # This function creates a mask and filters points inside the polygons
  data_clipped <- mask(data_spat, rng)
  
  # Convert the result back to a data frame if needed
  data_clipped_df <- as.data.frame(data_clipped)
  
  # Save or use the clipped data frame as needed
  write.csv(data_clipped_df, paste0("D:/hotspot/obs_", sp_list[sp], "_", ecoregion, "_clipped.csv"))
  
  # Optional: Plot to visualize the result
  plot(rng)
  plot(data_clipped, add = TRUE, col = 'red')
}



################
rng <- vect(paste0("D:/range maps/", sp, "_rng_", ecoregion, ".shp"))

spDat_proj <- spDat %>% 
  distinct(locality_id, latitude, longitude) %>%
  # convert to spatial features
  st_as_sf(coords = c("longitude", "latitude"), crs = 4326) %>% 
  # transform to projection of raster
  st_transform(crs = crs(rng))

extr <- extract(rng, vect(spDat_proj))



rng_proj <- project(rng, spp_richness)

rng_rst <- rasterize(rng_proj, spp_richness, 
                     background = 0,
                     field = 1)
rng_rst <- mask(rng_rst, spp_richness)
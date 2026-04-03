library(terra)
#spp <- "piwo"
spp <- c("piwo", "nofl", "dowo", "hawo",  "rbsa", "acwo", "attw",
         "whwo", "rnsa", "bbwo", "wisa")

ecoregions <- c("nwmf")

#Turn the binomial rasters into a raster stack
f_names <- paste0("D:/hotspot/output/ecoregion/binary_", rep(spp, each = length(ecoregions)), 
                  "_", rep(ecoregions, times = length(spp)), "_clip.tif")
binomial_stack <- rast(f_names)
names(binomial_stack) <- spp
plot(binomial_stack)

#extract sum to get species richness
spp_richness <- sum(binomial_stack)
plot(spp_richness, bty="n", axes = FALSE, box=FALSE)
north(xy = "bottomleft", type =2, angle = 20)
sbar(200000, xy = "bottomleft", type = "bar", divs = 2, scaleby = 1000, below = "km")#, cex = 0.8, type = "bar", divs = 2) 
writeRaster(spp_richness, "D:/hotspot/output/ecoregion/spp_richness_nwmf_clip.tif", overwrite = TRUE)
plot_nm <- paste0("D:/hotspot/output/ecoregion/spp_richness_", "nwmf", "_clip.png")
png(plot_nm, height=nrow(spp_richness), width=ncol(spp_richness)) 
plot(spp_richness, bty="n", axes = FALSE, box=FALSE, legend = TRUE)
dev.off()

#background range maps
library(terra)
for(sp in spp){
  rng <- vect(paste0("D:/range maps/", sp, "_rng_", ecoregions, ".shp"))
  rng_proj <- project(rng, spp_richness)

  rng_rst <- rasterize(rng_proj, spp_richness, 
                        background = 0,
                        field = 1)
  rng_rst <- mask(rng_rst, spp_richness)
  f_nm <- paste0("D:/range maps/", sp, "_rng_", ecoregions, "_rst.tif") 
  writeRaster(rng_rst, filename = f_nm, overwrite =  TRUE)
  
}


#Turn the range rasters into a raster stack
f_names_rng <- paste0("D:/range maps/", rep(spp, each = 1), "_rng_", ecoregions, "_rst.tif")
range_stack <- rast(f_names_rng)
names(range_stack) <- spp

#extract sum to get species richness
rng_richness <- sum(range_stack)
plot(rng_richness, bty="n", axes = FALSE, box=FALSE)
north(xy = "left", type =2, angle = 20)
sbar(200000, xy = "bottomleft", type = "bar", divs = 2, scaleby = 1000, below = "km")#, cex = 0.8, type = "bar", divs = 2) 
writeRaster(rng_richness, "D:/hotspot/output/ecoregion/rng_richness_nwmf_clip.tif", overwrite = TRUE)
plot_nm <- paste0("D:/hotspot/output/ecoregion/rng_richness_", "nwmf", "_clip.png")
png(plot_nm, height=nrow(rng_richness), width=ncol(rng_richness)) 
plot(rng_richness, bty="n", axes = FALSE, box=FALSE, legend = TRUE)
dev.off()






#HOW DO I DIVIDE GRID CELL VALUES OF ONE RASTER BY VALUES OF ANOTHER?

spp_richness <- rast("D:/hotspot/output/ecoregion/spp_richness_nwmf_clip.tif")


#rng_reclass_df <- c(0:10, 
#                    0.5, 1:10)
#rng_reclass_m <- matrix(rng_reclass_df,
#                        ncol = 2,
#                        byrow = FALSE)
#rng_reclass <- classify(rng_richness,
#                        rcl = rng_reclass_m, 
#                        filename = "D:/hotspot/output/ecoregion/rng_reclass_nwmf.tif",
#                        overwrite = TRUE)




#convert rng_richness to just those areas with higher richness (>=6 spp. expected)
rng_reclass_df <- c(0:10,
                NA, NA, NA, NA, NA, NA, NA, 7:10)
rng_reclass_m <- matrix(rng_reclass_df,
                    ncol = 2,
                    byrow = FALSE)
rng_reclass <- classify(rng_richness,
                            rcl = rng_reclass_m, 
                            filename = "D:/hotspot/output/ecoregion/rng_reclass_nwmf_clip.tif",
                            overwrite = TRUE)

prop_richness <- spp_richness / rng_reclass

#convert species richness into a raster of proportion based on our observed richness divided by expected richness based on range maps
prop_reclass_df <- data.frame(From = c(0, 0.7),
                              To =   c(0.7, Inf),
                              Becomes = c(0, 1))
prop_reclass_m <- as.matrix(prop_reclass_df)
                       
prop_reclass <- classify(prop_richness,
                        rcl = prop_reclass_m, 
                        filename = "D:/hotspot/output/ecoregion/prop_reclass_nwmf_clip.tif",
                        overwrite = TRUE)


#rcl_collapsed <- data.frame(from = c(0:6),
#                            to = c(0, 0, 0, 0, 0, 1, 1))
#library(raster)
#hotspot_rst <- reclassify(spp_richness, rcl_collapsed)

#plot(hotspot_rst)
plot(prop_reclass)
plot_nm2 <- paste0("D:/hotspot/output/ecoregion/hotspots_", "nwmf", "_clip.png")
png(plot_nm2, height=nrow(prop_reclass), width=ncol(prop_reclass)) 
plot(prop_reclass, bty="n", axes = FALSE, box=FALSE, legend = FALSE)
north(xy = "right", type =2, angle = 20)
sbar(200000, xy = "bottomright", type = "bar", divs = 2, scaleby = 1000, below = "km")
legend(x = -1990000, y = "2700000", legend = c("Hotspots"), fill = "forestgreen", cex = 0.8)
dev.off()

fcl_mat <- focalMat(binomial_stack, 45, type = "circle")
fcl_rst <- focal(binomial_stack, fcl_mat, fun = "sum")
names(fcl_rst) <- paste0("evergreen_combined_", bd)
writeRaster(fcl_rst_ev, fcl_rst_fn_ev, overwrite = TRUE)



#Turn the binomial rasters into a raster stack
q_names <- paste0("D:/hotspot/output/ecoregion/quants_", rep(spp, each = length(ecoregions)), 
                  "_", rep(ecoregions, times = length(spp)), "_clip.tif")
quantile_stack <- rast(q_names)
names(quantile_stack) <- spp
plot(quantile_stack)

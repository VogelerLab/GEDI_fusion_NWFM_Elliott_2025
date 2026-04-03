#This is a list of the files and description of each used in the analysis of woodpecker distributions in the NWFM and MWCF ecoregions, which is described in the paper "Modelling forest bird distributions with bioclimatic, forest composition, and GEDI fusion forest structure variables: the importance of ecoregional perspectives" 
  
"all_bird_data.R" #make the individual sp_data.csv files, plus maps of ebird observations
"birdData.R" #make the file with all species combined into a single file
"ecoregion_datasets.R" #combine ebird data points with ecoregion
"MODIS_obtain.R" #to download the modis data and save raster to computer...only should need to do this once
"MODIS_combine.R" #to combine modis data from saved raster
"vars_combine2.R" #to create gedi and bioclim csv data from saved raster
"clip to range.R" #to clip the dataset to only the range of the species of interest
"dataset_for_RF2_ecoregion_nwmf_clip.R" #to combine all data, clip the dataset to only the range of the species of interest, and set up test/training data for all 
"rf_prep2_ecoregion_nwmf.R" #select vars for rf...this will need to be hand selected for each species
"rf_analysis_ecoregion_clip.R" #complete rf for the final analysis
"prediction_dataset.R" #creates covar_stack_full.tif
"vars_combine_pred.R" #to create the prediction surface files including deciduous_combined_540.tif
"pred_effort.R" #to create the "covar_stack_mwcf_m.tif"
"prediction_surface.R" #makes "ecoregions[er]_pred_surface.tif"
"rf_prediction_ecoregion_nwmf_clip.R" #complete spatial predictions
"ecoregion_quantiles_nwmf_clip.R" #to find thresholds to get binary grids
"hotspots_ecoregion_nwmf_clip.R" #combine individual species maps to get species richness and hotspots
"rf_analysis_ecoregion_plots_fig3 updated_clip.R" #creates figures for the manuscript
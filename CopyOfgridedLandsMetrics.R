library(landscapemetrics)
library(sf)
library(terra)
library(tidyr)
library(raster)
library(maptools)

# read data ----------------------------------------------------
dieng <- raster('./data/2021_1.tif')
grid <- shapefile('./data/grid_A.shp')

plot(dieng)
plot(st_geometry(grid), add = TRUE)


# calculate lsm for particular polygons ------------------------------------
grid_landscapes = sample_lsm(dieng, y=grid,
                             shape='square', 
                            what = "lsm_l_division", return_raster = T)
                              
                                   #"lsm_l_lpi","lsm_l_mesh","lsm_l_division","lsm_l_frac_mn"                              
                                  #"lsm_l_ai", "lsm_l_area_mn", "lsm_l_cai_mn", "lsm_l_circle_mn", "lsm_l_cohesion", "lsm_l_condent", "lsm_l_contag", "lsm_l_contig_mn", "lsm_l_dcad", "lsm_l_division", "lsm_l_ed", "lsm_l_enn_mn", "lsm_l_ent", "lsm_l_frac_mn", "lsm_l_iji", "lsm_l_joinent", "lsm_l_lpi", "lsm_l_lsi","lsm_l_mesh", "lsm_l_np", "lsm_l_pd", "lsm_l_shape_mn", "lsm_l_split", "lsm_l_ta", "lsm_l_te", "lsm_l_te"
grid_landscapes

# connect values to polygons ----------------------------------------------
grid_landscapes_w = pivot_wider(grid_landscapes, 
                               id_cols = plot_id,
                               names_from = metric, 
                               values_from = value)

connect = cbind(grid, grid_landscapes_w)

class(connect)

dir.create('./output')

writeSpatialShape(connect, "./output/connect")

# viz results as image -------------------------------------------------------------

plot(connect["division"])

#?? How to visualize result as shape file or raster file??
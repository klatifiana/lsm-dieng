install.packages("sf")
install.packages("cli")
install.packages("tidyr")

library(landscapemetrics)
library(sf)
library(terra)
library(tidyr)
library(raster)

# read data ----------------------------------------------------
dieng <- rast("D:/Analisis Spasial Habitat/Fragmentation/2021_1.tif")
grid <- read_sf(dsn = "D:/Analisis Spasial Habitat/Fragmentation/", layer = "grid_A")

plot(dieng, type = "classes")
plot(st_geometry(grid), add = TRUE)


# calculate lsm for particular polygons ------------------------------------
grid_landscapes = sample_lsm(dieng, grid,
                            what = c("lsm_l_division"))
                              
                                   #"lsm_l_lpi","lsm_l_mesh","lsm_l_division","lsm_l_frac_mn"                              
                                  #"lsm_l_ai", "lsm_l_area_mn", "lsm_l_cai_mn", "lsm_l_circle_mn", "lsm_l_cohesion", "lsm_l_condent", "lsm_l_contag", "lsm_l_contig_mn", "lsm_l_dcad", "lsm_l_division", "lsm_l_ed", "lsm_l_enn_mn", "lsm_l_ent", "lsm_l_frac_mn", "lsm_l_iji", "lsm_l_joinent", "lsm_l_lpi", "lsm_l_lsi","lsm_l_mesh", "lsm_l_np", "lsm_l_pd", "lsm_l_shape_mn", "lsm_l_split", "lsm_l_ta", "lsm_l_te", "lsm_l_te"
grid_landscapes

# connect values to polygons ----------------------------------------------
grid_landscapes_w = pivot_wider(grid_landscapes, 
                               id_cols = plot_id,
                               names_from = metric, 
                               values_from = value)
connect = cbind(grid, grid_landscapes_w)


# viz results as image -------------------------------------------------------------

plot(connect["division"])

#?? How to visualize result as shape file or raster file??
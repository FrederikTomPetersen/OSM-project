
#-----------------------------------------------------------------------------
#                               OpenStreetMap


# Et lille projekt der påsigt skal sammensætte et vejnetværk, der kan bruges til at lave afstandsanalsyser


devtools::install_github("ropensci/osmdata")
install.packages("osmdata")
library("osmdata")

bboxdenmark <- getbb ("danmark") # seems worng and return data from canada

#---------------------------------------------------------------------------
#manually create bbox for Denmark

x =   c(8.0043,15.2223)       # longitude
y =   c(54.5352,57.7875)      # Latitude

xy = cbind(x,y)  # bind to matrix
S <-  sp::SpatialPoints(xy) #create spatial points
box <- sp::bbox(S) #Creates bbox of spatial points


#----------------------------------------------------------------------------
# Trying to recieve data on roads
q1 <- opq(bbox = sp::bbox(S)) %>% add_osm_feature(key="highway", value = "residential")
q1xml <-  osmdata_xml(q1, "data.xml")
q1sf <- osmdata_sf(q1)
q1sf <- osmdata_sf(q1,q1xml)
lines <-  q1sf$osm_lines


setwd("C:/Users/ftp/OneDrive - Erhvervsstyrelsen/Github/")
sf::write_sf(lines,"lines.shp")


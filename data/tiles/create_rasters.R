library(raster)
library(ncdf4)

in.dir <- '/scratch/gr556/Vulcan/output_data/gridded/ODIAC/Contiguous_US/'
out.dir <- '/projects/gurney_lab/Group_members/Geoff/leaflet/'

f.list <- list.files(in.dir)

for(f in f.list) {
  infile  <- paste0(in.dir,f)
  outfile <- paste0(out.dir, gsub(".nc",".tif",f))

  r <- raster(infile)
  projection(r) <- "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0"
  writeRaster(r, outfile, format="GTiff", overwrite=T)

}

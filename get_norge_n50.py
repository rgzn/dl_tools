# -*- coding: utf-8 -*-
#!/usr/bin/env python
#"""
#Downloader for GeoNorge topo rasters
#"""

import pandas as pd
import geopandas as gpd
# from geopandas.tools import sjoin
from argparse import ArgumentParser
import requests
import sys
# import geojsonio
from shapely.geometry import Point, Polygon
from urllib.request import urlretrieve

parser = ArgumentParser()
# parser.add_argument("latitude", help="latitude in decimal degrees",
#                     type=float)
# parser.add_argument("longitude", help="longitude in decimal degrees",
#                     type=float)
# parser.add_argument("-v", "--verbosity", action="store_true",
#                     help="increase output verbosity")
parser.add_argument("-d", "--dir", 
                    help="download directory",
                    type=str)
args = parser.parse_args()

if args.dir:
    download_path = args.dir
else:
    download_path = "./"

# generate url for n50 raster data
def gen_geonorge_n50_url(cell, proj):
    zone = proj % 100
    base_url = "https://nedlasting.geonorge.no/geonorge/Basisdata/N50RasterUTM33/TIFF/"
    filename = f'Basisdata_{cell}_Celle_{proj}_N50RasterUTM{zone}_TIFF.zip'
    url = base_url + filename
    return(url)

# generate url for n50 raster data
def get_geonorge_n50_url(cell, proj):
    zone = proj % 100
    base_url = "https://nedlasting.geonorge.no/geonorge/Basisdata/N50RasterUTM33/TIFF/"
    filename = f'Basisdata_{cell}_Celle_{proj}_N50RasterUTM{zone}_TIFF.zip'
    url = base_url + filename
    urlretrieve(url, filename = download_path + filename)
    return(filename)




# lat lon inputs:
# lat = args.lat
# lon = args.lon
# lat = 23.166667
# lon =  70.383333
# input_point = gpd.points_from_xy([lon], [lat])[0]


my_epsg = "EPSG:25833"

# Url dictionary for coverage vector files
# the dekning geojson files define the grid cells for each projection
# key: integer EPSG code 
# value: string url for source file
dekning_urls = { 
    25832 : "https://norgeskart.no/json/dekning/raster/32.geojson",
    25833 : "https://norgeskart.no/json/dekning/raster/33.geojson",
    25835 : "https://norgeskart.no/json/dekning/raster/35.geojson"
    }

# Coverage geometries
# geopandas data with coverage geometries
dekning_geoms = {}
for epsg_code, url in dekning_urls.items():
    crs = "EPSG:%d" % epsg_code
    dekning_geoms[epsg_code] = gpd.read_file(url)
    dekning_geoms[epsg_code].crs = crs
    (dekning_geoms[epsg_code])['source_proj'] = epsg_code


cells = pd.concat(dekning_geoms.values()).reset_index()
cells.crs = my_epsg

bounds = cells.dissolve(by='source_proj').reset_index()
bounds['area'] = bounds.area
main_proj = bounds.sort_values(by='area', ascending=False).\
    head(1)['source_proj'][1]

main_bounds = bounds[bounds.source_proj == main_proj]
# bounds['bbox'] = bounds.envelope

secondary_cells = cells[cells.source_proj != main_proj]

    

cells.apply(lambda cell: get_geonorge_n50_url(cell['n'], cell['source_proj']), axis=1)






    
# dekning_boundaries = {}
# for epsg_code, grids in dekning_geoms.items():
#     dekning_boundaries[epsg_code] = dekning_geoms[epsg_code].unary_union
    



    

    


    

# def get_dekning(epsg_code, dekning_urls):
#     url = dekning_urls[epsg_code]
#     try:
#         r = requests.get(url)
#         r.raise_for_status()
#     except requests.exceptions.HTTPError as err:
#         print(err)
#         sys.exit(1)
#     dekning_geojson = r.content
#     dekning = ogr.CreateGeometryFromJson(dekning_geojson)
#     return(dekning)
    

ogr2ogr \
-nln "neighbourhoods" \
-lco "SCHEMA=phl" \
-lco "GEOM_TYPE=geography" \
-lco "GEOMETRY_NAME=geog" \
-lco "OVERWRITE=yes" \
PG:"host=localhost port=5432 dbname=musa509week3 user=postgres password=P123i,./g456" \
exercises/data/philadelphia-neighborhoods.geojson

ogr2ogr \
-nln "station_geo" \
-lco "SCHEMA=indego" \
-lco "GEOM_TYPE=geography" \
-lco "GEOMETRY_NAME=geog" \
-lco "OVERWRITE=yes" \
PG:"host=localhost port=5432 dbname=musa509week3 user=postgres password=P123i,./g456" \
exercises/data/phl.json

PGPASSWORD='P123i,./g456' psql -h localhost -p 5432 -U postgres -d musa509week3 \
-c "\copy indego.station FROM 'F:/GitHub/course-info_Cloud_computing/week03/exercises/data/indego-stations-2026-01-01.csv' WITH (HEADER true, FORMAT CSV)"

# running docker cause i didn't the first week
docker run --rm -d \
  --name postgis-container \
  -e POSTGRES_PASSWORD='P123i,./g456' \
  -p 5432:5432 \
  -v pgdata:/var/lib/postgresql/data \
  --mount type=bind,source=/f/GitHub/course-info_Cloud_computing/,target=/local_data,readonly \
  postgis/postgis


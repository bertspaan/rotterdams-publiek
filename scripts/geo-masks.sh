#!/usr/bin/env bash

# This script creates GeoJSON polyon masks from georeference annotations

cd "$(dirname "$0")"

../../cli/geo-mask.js -a ../annotations/NL-RtSA_4001_1985-1014-01.json > ../geo-masks/NL-RtSA_4001_1985-1014-01.geojson
../../cli/geo-mask.js -a ../annotations/NL-RtSA_4201_I-259-10.json > ../geo-masks/NL-RtSA_4201_I-259-10.geojson
../../cli/geo-mask.js -a ../annotations/NL-RtSA_4201_I-138-02-5.json > ../geo-masks/NL-RtSA_4201_I-138-02.geojson
../../cli/geo-mask.js -a ../annotations/NL-RtSA_4201_1970-2043.json > ../geo-masks/NL-RtSA_4201_1970-2043.json.geojson
../../cli/geo-mask.js -a ../annotations/NL-RtSA_4001_1972-755-1.json > ../geo-masks/NL-RtSA_4001_1972-755-1.geojson

jq -s '{type:"FeatureCollection",features:[.[].features|add]}' ../geo-masks/* \
  > ../geo-masks/all-geo-masks.geojson

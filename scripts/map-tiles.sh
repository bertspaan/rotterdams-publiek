#!/usr/bin/env bash

cd "$(dirname "$0")"

cat ../annotations/NL-RtSA_4201_I-259-10.json | \
  ../../cli/annotation-to-gdal-script.js -s ../maps/ -o ../tiles | bash

cat ../annotations/NL-RtSA_4201_I-138-02-5.json | \
  ../../cli/annotation-to-gdal-script.js -s ../maps/ -o ../tiles | bash

cat ../annotations/NL-RtSA_4201_1970-2043.json | \
  ../../cli/annotation-to-gdal-script.js -s ../maps/ -o ../tiles | bash

cat ../annotations/NL-RtSA_4001_1972-755-1.json | \
  ../../cli/annotation-to-gdal-script.js -s ../maps/ -o ../tiles | bash

cat ../annotations/NL-RtSA_4001_1985-1014-01.json | \
  ../../cli/annotation-to-gdal-script.js -s ../maps/ -o ../tiles | bash

cat ../annotations/plattegrond-van-rotterdam-in-25-bladen-1910.json | \
  ../../cli/annotation-to-gdal-script.js \
  -s ../maps/plattegrond-van-rotterdam-in-25-bladen-1910 \
  -o ../tiles | bash

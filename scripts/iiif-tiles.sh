#!/usr/bin/env bash

# This script creates tiled IIIF resources and info.json files from original image files:

cd "$(dirname "$0")"

../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/NL-RtSA_4001_1985-1014-01.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/NL-RtSA_4001_1972-755-1.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/NL-RtSA_4201_1970-2043.tif -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/NL-RtSA_4201_I-259-10.tif -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/NL-RtSA_4201_I-138-02-5.jpg -o ./iiif

../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/plattegrond-van-rotterdam-in-25 bladen-1910/863C7B0202ED49629FF21D3CC48E7A24.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/plattegrond-van-rotterdam-in-25 bladen-1910/A136B927DA744CD2BEA9F1A3FF2271BA.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/plattegrond-van-rotterdam-in-25 bladen-1910/69B895061B4348729BFCC3F785B60A76.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/plattegrond-van-rotterdam-in-25 bladen-1910/8C000D39DCD544888DE21A5F02EC75D8.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/plattegrond-van-rotterdam-in-25 bladen-1910/E17C0C6C9801455497366626D2EA8A29.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/plattegrond-van-rotterdam-in-25 bladen-1910/6D3A2D321823462A9A606210390651B5.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/plattegrond-van-rotterdam-in-25 bladen-1910/3E0AF0D3DEE145318C457D9FE875DB6C.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/plattegrond-van-rotterdam-in-25 bladen-1910/637888E013C749D189E0FBEA40AAE49A.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/plattegrond-van-rotterdam-in-25 bladen-1910/4F0DA8FB957E430D9C1C45AE4BBC3C06.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/plattegrond-van-rotterdam-in-25 bladen-1910/C50AD01841D54576A6C8B642938A01DD.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/plattegrond-van-rotterdam-in-25 bladen-1910/AD324025E81A42C8AEF74EFE049C7D8B.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/plattegrond-van-rotterdam-in-25 bladen-1910/8D75837EA87148228528DB79FCFAF488.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/plattegrond-van-rotterdam-in-25 bladen-1910/EF863AEF0BF04473908738EB4971A5E3.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/plattegrond-van-rotterdam-in-25 bladen-1910/13B51C4B387C4480A0347D6C87FB921B.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/plattegrond-van-rotterdam-in-25 bladen-1910/AD0567937AFC415096DCC6E6686FE32E.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/plattegrond-van-rotterdam-in-25 bladen-1910/2058A487AD284CD988282D2DC60AA432.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/plattegrond-van-rotterdam-in-25 bladen-1910/6A9C823CC3234837B35A55362EDD3BFC.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/plattegrond-van-rotterdam-in-25 bladen-1910/B79F5D048E584873BC38A35BFAEC49CC.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/plattegrond-van-rotterdam-in-25 bladen-1910/3269A4524A3B42F3BA6D9EBC92B0B888.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/plattegrond-van-rotterdam-in-25 bladen-1910/A96CC28B52154C2EBED72E4B9DB4EAAF.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/plattegrond-van-rotterdam-in-25 bladen-1910/59DBAF5BE1CC4C09BCD3610F6B7ED6D3.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/plattegrond-van-rotterdam-in-25 bladen-1910/BBAE5AD560CC41719B7420ED659C6D4D.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/plattegrond-van-rotterdam-in-25 bladen-1910/AE2AD818169243EFB9207C98CA37ED59.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/plattegrond-van-rotterdam-in-25 bladen-1910/E5FBDF15ECCB4E2B9DF2A782FF3EDCF6.jpg -o ./iiif
../cli/iiif-tiles.js -h 'https://rotterdamspubliek.nl' -i ./maps/plattegrond-van-rotterdam-in-25 bladen-1910/BA70EAF4A39249A7AF9CEAFEFCDD7470.jpg -o ./iiif

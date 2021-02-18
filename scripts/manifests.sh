#!/usr/bin/env bash

cd "$(dirname "$0")"

../../cli/iiif-manifest.js -m 'https://raw.githubusercontent.com/bertspaan/rotterdams-publiek/master/manifests/plattegrond-van-rotterdam-in-25-bladen-1910.json' \
  -i https://rotterdamspubliek.nl/iiif/863C7B0202ED49629FF21D3CC48E7A24/info.json \
  -i https://rotterdamspubliek.nl/iiif/A136B927DA744CD2BEA9F1A3FF2271BA/info.json \
  -i https://rotterdamspubliek.nl/iiif/69B895061B4348729BFCC3F785B60A76/info.json \
  -i https://rotterdamspubliek.nl/iiif/8C000D39DCD544888DE21A5F02EC75D8/info.json \
  -i https://rotterdamspubliek.nl/iiif/E17C0C6C9801455497366626D2EA8A29/info.json \
  -i https://rotterdamspubliek.nl/iiif/6D3A2D321823462A9A606210390651B5/info.json \
  -i https://rotterdamspubliek.nl/iiif/3E0AF0D3DEE145318C457D9FE875DB6C/info.json \
  -i https://rotterdamspubliek.nl/iiif/637888E013C749D189E0FBEA40AAE49A/info.json \
  -i https://rotterdamspubliek.nl/iiif/4F0DA8FB957E430D9C1C45AE4BBC3C06/info.json \
  -i https://rotterdamspubliek.nl/iiif/C50AD01841D54576A6C8B642938A01DD/info.json \
  -i https://rotterdamspubliek.nl/iiif/AD324025E81A42C8AEF74EFE049C7D8B/info.json \
  -i https://rotterdamspubliek.nl/iiif/8D75837EA87148228528DB79FCFAF488/info.json \
  -i https://rotterdamspubliek.nl/iiif/EF863AEF0BF04473908738EB4971A5E3/info.json \
  -i https://rotterdamspubliek.nl/iiif/13B51C4B387C4480A0347D6C87FB921B/info.json \
  -i https://rotterdamspubliek.nl/iiif/AD0567937AFC415096DCC6E6686FE32E/info.json \
  -i https://rotterdamspubliek.nl/iiif/2058A487AD284CD988282D2DC60AA432/info.json \
  -i https://rotterdamspubliek.nl/iiif/6A9C823CC3234837B35A55362EDD3BFC/info.json \
  -i https://rotterdamspubliek.nl/iiif/B79F5D048E584873BC38A35BFAEC49CC/info.json \
  -i https://rotterdamspubliek.nl/iiif/3269A4524A3B42F3BA6D9EBC92B0B888/info.json \
  -i https://rotterdamspubliek.nl/iiif/A96CC28B52154C2EBED72E4B9DB4EAAF/info.json \
  -i https://rotterdamspubliek.nl/iiif/59DBAF5BE1CC4C09BCD3610F6B7ED6D3/info.json \
  -i https://rotterdamspubliek.nl/iiif/BBAE5AD560CC41719B7420ED659C6D4D/info.json \
  -i https://rotterdamspubliek.nl/iiif/AE2AD818169243EFB9207C98CA37ED59/info.json \
  -i https://rotterdamspubliek.nl/iiif/E5FBDF15ECCB4E2B9DF2A782FF3EDCF6/info.json \
  -i https://rotterdamspubliek.nl/iiif/BA70EAF4A39249A7AF9CEAFEFCDD7470/info.json \
  > ../manifests/plattegrond-van-rotterdam-in-25-bladen-1910.json

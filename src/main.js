import App from './App.svelte'

import maps from '../maps.yaml'
import geoMasks from '../geo-masks/all-geo-masks.geojson'

const yearsPadding = 10

const yearsRange = maps.reduce((yearsRange, map) => {
  const minYear = Math.min(...map.years) - yearsPadding
  const maxYear = Math.max(...map.years) + yearsPadding

  return [
    Math.min(yearsRange[0], minYear),
    Math.max(yearsRange[1], maxYear)
  ]
}, [Infinity, -Infinity])

const app = new App({
  target: document.body,
  props: {
    geoMasks,
    maps: maps
      .filter((map) => map.tiles),
    yearsPadding,
    yearsRange
  }
})

export default app

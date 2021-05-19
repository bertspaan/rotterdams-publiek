/* global URLSearchParams */

import App from './App.svelte'

import maps from '../maps.yaml'
import geoMasks from '../geo-masks/all-geo-masks.geojson'

const yearsPadding = 10

const path = window.location.hash.slice(1)
const urlParams = new URLSearchParams(path)
const hashYear = parseInt(urlParams.get('year'))

let mapIndex
let minYearDiff = Infinity

const yearsRange = maps.reduce((yearsRange, map, index) => {
  const minYear = Math.min(...map.years)
  const maxYear = Math.max(...map.years)

  if (hashYear) {
    let yearDiff = 0
    if (hashYear < minYear) {
      yearDiff = minYear - hashYear
    } else if (hashYear > maxYear) {
      yearDiff = hashYear - maxYear
    }

    if (yearDiff < minYearDiff) {
      minYearDiff = yearDiff
      mapIndex = index
    }
  }

  return [
    Math.min(yearsRange[0], minYear - yearsPadding),
    Math.max(yearsRange[1], maxYear + yearsPadding)
  ]
}, [Infinity, -Infinity])

const app = new App({
  target: document.body,
  props: {
    geoMasks,
    mapIndex,
    maps: maps
      .filter((map) => map.tiles),
    yearsPadding,
    yearsRange
  }
})

export default app

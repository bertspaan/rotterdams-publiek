<script>
	import { onMount } from 'svelte'
	import RangeSlider from 'svelte-range-slider-pips'
	import booleanIntersects from '@turf/boolean-intersects'

	export let maps
	export let geoMasks
	export let yearsPadding
	export let yearsRange

	let map
	let mapYearsRange
	let mapIndex = 0

	$: map = maps[mapIndex]
	$: mapYearsRange = [
		Math.min(...map.years) - yearsPadding,
		Math.max(...map.years) + yearsPadding
	]
	$: updateMap(map)

	let leafletMap

	let locations
	let locationsLayer
	let tileLayer

	const emptyGeoJSON = {
		type: 'FeatureCollection',
		features: []
	}

	function handleKeydown (event) {
		if (event.key === '[') {
			previousMap()
		} else if (event.key === ']') {
			nextMap()
		} else if (event.code === 'Space') {
			if (tileLayer) {
				tileLayer.setOpacity(0)
			}
		}
	}

	function handleKeyup (event) {
 		if (event.code === 'Space') {
			if (tileLayer) {
				tileLayer.setOpacity(1)
			}
		}
	}

	function yearsOverlap(yearsRange1, yearsRange2) {
		return yearsRange1[0] <= yearsRange2[1] && yearsRange2[0] <= yearsRange1[1]
	}

	function sliderChange (event) {
		const yearsRange = event.detail.values
		updateLocations(yearsRange, false)
	}

	function updateLocations (yearsRange, fitBounds = true) {
		if (locationsLayer && locations) {

			const filteredGeoMasks = geoMasks.features
				.filter((feature) => {
					const imageId = feature.properties.imageService['@id']
					return imageId.endsWith(map.id)
				})

			let geoMask
			if (filteredGeoMasks && filteredGeoMasks.length === 1) {
				geoMask = filteredGeoMasks[0]
			}

			const filteredLocations = {
				type: 'FeatureCollection',
				features: locations.features
					.filter((feature) => {
						const featureYears = [
							parseInt(feature.properties.startyear) || -Infinity,
							parseInt(feature.properties.endyear) || Infinity
						]

						return yearsOverlap(yearsRange, featureYears) && booleanIntersects(geoMask, feature)
					})
			}

			locationsLayer.clearLayers()
			locationsLayer.addData(filteredLocations)
			if (fitBounds) {
				leafletMap.fitBounds(locationsLayer.getBounds(), {
					padding: [5, 5]
				})
			}
		}
	}

	function previousMap () {
		mapIndex = (mapIndex - 1 + maps.length) % maps.length
	}

	function nextMap () {
		mapIndex = (mapIndex + 1) % maps.length
	}

	function updateMap (map) {
		if (!locations) {
			return
		}

		updateLocations(yearsRange)

		if (tileLayer) {
			tileLayer.addTo(leafletMap)
			tileLayer.setUrl(map.tiles)
		}
	}

	function createPopup (feature) {
		const properties = feature.properties
		const width = 250

		let html = [
			`<h3>${properties.label}</h3>`
		]

		if (properties.startyear || properties.endyear) {
			const startYear = properties.startyear || ''
			const endYear = properties.endyear || ''

			html.push(`<div><span>${startYear} – ${endYear}</span>⁠</div>`)
		}

		if (properties.image) {
			html.push(`<img style="width: ${width}px;" src="${properties.image}?width=${width}px" />`)
		}

		html.push(`<p><a href="https://rotterdamspubliek.nl/plekken/plek.php?qid=${properties.wdid}">Bekijk op Rotterdams Publiek</a></p>`)

		return html.join('\n')
	}

	onMount(async () => {
	 	leafletMap = L.map('map', {
			 attributionControl: false
		 }).setView([51.9200, 4.4895], 13)

		// const tileUrl = 'https://stamen-tiles.a.ssl.fastly.net/toner-lite/{z}/{x}/{y}.png'
		const tileUrl = 'https://a.basemaps.cartocdn.com/rastertiles/light_all/{z}/{x}/{y}.png'

		const baseLayer = L.tileLayer(tileUrl, {
			maxZoom: 18
		}).addTo(leafletMap)

		tileLayer = L.tileLayer('', {
			maxZoom: 18,
			tms: true
		})

		const style = {
			color: '#950305',
			weight: 3,
			opacity: 0.8,
			fillOpacity: 0.3
		}

		locationsLayer = L.geoJSON(emptyGeoJSON, {
			onEachFeature: (feature, layer) => {
        layer.bindPopup(createPopup(feature))
    	},
			pointToLayer: (feature, latlng) => {
				return new L.CircleMarker(latlng, {
					...style,
					radius: 8,
					weight: 2,
				})
			},
			style
		}).addTo(leafletMap)
	})

	async function fetchLocations (url) {
		const response = await fetch(url)
		locations = await response.json()

		updateMap(map)
	}

	fetchLocations('https://raw.githubusercontent.com/mmmenno/rotterdams-publiek/master/plekken/kaart/locaties.geojson')
</script>

<main>
	<div id="map"></div>
	<!-- Spatiebalk: zet kaartlaag even aan/uit -->
	<footer class="grid-container">
	  <div class="previous">
			<button on:click={previousMap}>←&nbsp;<span>Vorige</span></button>
		</div>
  	<div class="next">
			<button on:click={nextMap}><span>Volgende</span>&nbsp;→</button>
		</div>
  	<div class="metadata">
			<span class="title"><a href={map.handle}>{map.displayTitle}</a></span>
			<span class="years">{map.years.join(' – ')}</span>
		</div>
  	<div class="controls">
			<RangeSlider range
				on:change={sliderChange}
				springValues={{ stiffness: 1, damping: 1 }}
				pips={true} pipstep={10}
				float={true} hover={true}
				first='label' last='label'
				min={Math.floor(yearsRange[0] / 10) * 10} max={Math.ceil(yearsRange[1] / 10) * 10}
				values={mapYearsRange} />
			<!-- <div>
				<label><input type="checkbox" name="fit-bounds" value="value">Centreer kaart</label>
				<label><input type="checkbox" name="checkbox" value="value">Gebruik jaar van kaart</label>
				<label><input type="checkbox" name="checkbox" value="value">Verberg locaties die buiten kaart vallen</label>
			</div> -->
		</div>
	</footer>
</main>
<svelte:window
	on:keyup={handleKeyup}
	on:keydown={handleKeydown} />

<style>
main {
	width: 100%;
	height: 100%;

	display: flex;
	flex-direction: column;
}

#map {
	flex-grow: 1;
}

footer {
	display: flex;
	flex-direction: row;
	justify-content: space-between;
}

.grid-container {
  display: grid;
  grid-template-columns: min-content 1fr min-content;
  grid-template-rows: min-content min-content;
  gap: 0.5em;
	padding: 0.5em;
  grid-template-areas:
    "previous metadata next"
    ". controls .";
}

.previous {
	grid-area: previous;
}

.next {
	grid-area: next;
}

.metadata {
	grid-area: metadata;
	place-self: center
}

.controls {
	grid-area: controls;
}

.title a, .title a:visited {
	color: black;
}

.years {
	color: #999;
}

footer button {
	margin: 0;
  padding: 0;
	color: #c2675d;
	background: none;
	border: none;
	font-weight: bold;
	cursor: pointer;
}

footer button:hover span {
	text-decoration: underline;
}
</style>
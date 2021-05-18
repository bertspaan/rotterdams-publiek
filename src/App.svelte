<script>
	import { onMount } from 'svelte'
	import RangeSlider from 'svelte-range-slider-pips'
	import booleanIntersects from '@turf/boolean-intersects'

	export let maps
	export let geoMasks
	export let yearsPadding
	export let yearsRange

	let sliderStep = 10

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

	function handleResize () {
		if (window.innerWidth < 600) {
			sliderStep = 50
		} else if (window.innerWidth < 1000) {
			sliderStep = 20
		} else {
			sliderStep = 10
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

			const locationsFilteredByYear = {
				type: 'FeatureCollection',
				features: locations.features
					.filter((feature) => {
						const featureYears = [
							parseInt(feature.properties.startyear) || -Infinity,
							parseInt(feature.properties.endyear) || Infinity
						]

						return yearsOverlap(yearsRange, featureYears) // && booleanIntersects(geoMask, feature)
					})
			}

			const locationsFilteredByYearAndGeometry = {
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
			locationsLayer.addData(locationsFilteredByYear)
			if (fitBounds) {
				leafletMap.fitBounds(L.geoJson(locationsFilteredByYearAndGeometry).getBounds(), {
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

		const mapYearsRange = [
			Math.min(...map.years) - yearsPadding,
			Math.max(...map.years) + yearsPadding
		]

		updateLocations(mapYearsRange)

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

			html.push(`<span class="years">${startYear} – ${endYear}</span>⁠`)
		}

		if (properties.image) {
			html.push(`<a href="https://rotterdamspubliek.nl/plekken/plek.php?qid=${properties.wdid}"><img style="width: ${width}px;" src="${properties.image}?width=${width}px" /></a>`)
		}

		html.push(`<p><a href="https://rotterdamspubliek.nl/plekken/plek.php?qid=${properties.wdid}">Bekijk op Rotterdams Publiek</a></p>`)

		return html.join('\n')
	}

	onMount(async () => {
	 	leafletMap = L.map('map', {
			 minZoom: 13,
			 maxZoom: 18,
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
					radius: 5,
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
	handleResize()
</script>

<main>
	<div id="map"></div>
	<footer>
		<div class="maps">
			<div class="previous">
				<button on:click={previousMap}>←&nbsp;<span title="Volgende kaart - of gebruik de [-toets">Vorige</span></button>
			</div>
			<div class="metadata">
				<a class="title" title={map.displayTitle} href={map.handle}>{map.displayTitle}</a>
				<span class="years">{map.years.join(' – ')}</span>
			</div>
			<div class="next">
				<button on:click={nextMap}><span title="Volgende kaart - of gebruik de ]-toets">Volgende</span>&nbsp;→</button>
			</div>
		</div>
  	<div class="controls">
			<RangeSlider range
				on:change={sliderChange}
				springValues={{ stiffness: 1, damping: 1 }}
				pips={true} pipstep={sliderStep}
				float={true} hover={true}
				first='label' last='label' rest='label'
				min={Math.floor(yearsRange[0] / 10) * 10} max={2020}
				values={mapYearsRange} />
		</div>
	</footer>
</main>
<svelte:window
	on:keyup={handleKeyup}
	on:keydown={handleKeydown}
	on:resize={handleResize} />
<style>
:root {
	--red: #c2675d;
	--range-range: var(--red);
	--range-float: var(--red);
	--range-handle: var(--red);
	--range-handle-focus: var(--red);
}

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
	flex-direction: column;
	justify-content: space-between;
	padding: 0.5em;
}

.maps {
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	padding-bottom: 0.5em;
}

@media only screen and (max-width: 600px) {
	.maps button span {
		display: none;
	}
}

.previous {
	padding-right: 0.5em;
}

.next {
	padding-left: 0.5em;
}

.previous, .next {
	flex-shrink: 0;
}

.metadata {
	display: inline-block;
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}

.title, .title:visited {
	color: black;
}

footer button {
	margin: 0;
  padding: 0;
	color: var(--red);
	background: none;
	border: none;
	font-weight: bold;
	cursor: pointer;
}

footer button:hover span {
	text-decoration: underline;
}
</style>
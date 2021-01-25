<script>
	import { onMount } from 'svelte'

	// TODO: add year to each map
	// TODO: generate GeoJSON boundary for each map, using annotation
	import maps from '../maps.yaml'

	let locations
	let locationsLayer

	const emptyGeoJSON = {
		type: 'FeatureCollection',
		features: []
	}

	function updateLocations () {
		// TODO: only show correct buildings, based on map publication date!
		locationsLayer.clearLayers()
		locationsLayer.addData(locations)
	}

	onMount(async () => {
		const leafletMap = L.map('map').setView([51.9200, 4.4895], 13)

		const tileUrl = 'https://stamen-tiles.a.ssl.fastly.net/toner-lite/{z}/{x}/{y}.png'

		const baseLayer = L.tileLayer(tileUrl, {
			maxZoom: 18
		}).addTo(leafletMap)

		let layers = {}

		maps
			.filter((map) => map.tiles)
			.forEach((map, index) => {
				const layer = L.tileLayer(map.tiles, {
					maxZoom: 18,
					tms: true
				})

				layers[map.title] = layer

				if (index === 0) {
					layer.addTo(leafletMap)
				}
			})

		L.control.layers({'Base map': baseLayer}, layers).addTo(leafletMap)

		locationsLayer = L.geoJSON(emptyGeoJSON, {
			style: {
    		color: '#afe800',
    		weight: 5,
    		opacity: 0.65
			}
		}).addTo(leafletMap)
	})

	async function fetchLocations (url) {
		const response = await fetch(url)
		locations = await response.json()
		updateLocations()
	}

	fetchLocations('https://raw.githubusercontent.com/mmmenno/rotterdams-publiek/master/plekken/kaart/locaties.geojson')
</script>

<main>
	<div id="map"></div>
</main>

<style>
	main {
		width: 100%;
		height: 100%;
	}

	#map {
		width: 100%;
		height: 100%;
	}

	@media (min-width: 640px) {
		main {
			max-width: none;
		}
	}
</style>
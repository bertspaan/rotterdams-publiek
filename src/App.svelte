<script>
	import { onMount } from 'svelte'

	// TODO: add year to each map
	// TODO: generate GeoJSON boundary for each map, using annotation
	import maps from '../maps.yaml'

	const mapsWithTiles = maps
		.filter((map) => map.tiles)

	let mapIndex = 0
	$: map = mapsWithTiles[mapIndex]
	$: updateMap(map)

	let leafletMap

	let locations
	let locationsLayer
	let tileLayer

	const emptyGeoJSON = {
		type: 'FeatureCollection',
		features: []
	}

	function updateLocations () {
		// TODO: only show correct buildings, based on map publication date!
		locationsLayer.clearLayers()
		locationsLayer.addData(locations)
	}

	function previousMap () {
		mapIndex = (mapIndex - 1 + mapsWithTiles.length) % mapsWithTiles.length
	}

	function nextMap () {
		mapIndex = (mapIndex + 1) % mapsWithTiles.length
	}

	function updateMap (map) {
		if (tileLayer) {
			tileLayer.addTo(leafletMap)
			tileLayer.setUrl(map.tiles)
		}
	}

	onMount(async () => {
	 	leafletMap = L.map('map').setView([51.9200, 4.4895], 13)

		const tileUrl = 'https://stamen-tiles.a.ssl.fastly.net/toner-lite/{z}/{x}/{y}.png'

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

		// TODO: add popup with link:
		// https://rotterdamspubliek.nl/plekken/plek.php?qid=Q29569055

		locationsLayer = L.geoJSON(emptyGeoJSON, {
			pointToLayer: function (feature, latlng) {
				return new L.CircleMarker(latlng, {
					...style,
					radius: 8,
					weight: 2,
				})
			},
			style
		}).addTo(leafletMap)

		updateMap(map)
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
	<footer>
		<button on:click={previousMap}>Vorige</button>
		<h2>{map.displayTitle}</h2>
		<button on:click={nextMap}>Volgende</button>
	</footer>
</main>

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

	@media (min-width: 640px) {
		main {
			max-width: none;
		}
	}
</style>
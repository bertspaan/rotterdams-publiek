<script>
	import { onMount } from 'svelte'

	import maps from '../maps.yaml'

	let geojson

	onMount(async () => {
		const  map = L.map('map').setView([51.9200, 4.4895], 13)

		const tileUrl = 'https://stamen-tiles.a.ssl.fastly.net/toner-lite/{z}/{x}/{y}.png'
		L.tileLayer(tileUrl, {
			maxZoom: 18
		}).addTo(map)

		// TODO add layercontrol
		// make layer for each map in yaml

		// L.control.layers(baseMaps, overlayMaps).addTo(map);

	})

	async function fetchGeoJSON (url) {
		const response = await fetch(url)
		geojson = await response.json()

		// TODO add buildings to map, only show correct buildings!
		console.log(geojson)
		// https://leafletjs.com/examples/geojson/
	}

	fetchGeoJSON('https://raw.githubusercontent.com/mmmenno/rotterdams-publiek/master/plekken/kaart/locaties.geojson')
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
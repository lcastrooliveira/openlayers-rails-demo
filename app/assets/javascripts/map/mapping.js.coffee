class @Mapping

  @styleCache: {}

  @iconTypes: {
    'Informativo':'information_ready.png',
    'Hospedagem' :'lodge_ready.png',
    'Servicos' :'services_ready.png',
    'Tecnico Cientifico' : 'scientific_ready.png',
    'Lazer' : 'leizure_ready.png',
    'Religioso' : 'church_ready.png',
    'Alimentação': 'food_ready.png'
  }

  constructor: (@element) ->

  runMap: =>
    osmLayer = LayerFactory.createOSMTileLayer('Map (OSM)')
    bingMapsLayer = LayerFactory.createBingLayer('Satellite')

    center = ol.proj.transform([-54.31598, -25.00828],'EPSG:4326','EPSG:3857')
    view = new ol.View({center: center, zoom: 10})
    @map = new ol.Map({target: @element.attr('id')})
    @map.addLayer(bingMapsLayer)
    @map.addLayer(osmLayer)
    @map.setView(view)
    @element.data('map', map)

  addLayerSwitcher: =>
    layerSwitcher = new ol.control.LayerSwitcher({
      tipLabel: 'Legenda'
    })
    @map.addControl(layerSwitcher) #if @map != undefined

  addBeachWalkway: =>
    beachWalkwayStyle = MapStyles.getStrokeStyle([0,153,51,0.8],5)
    layer = LayerFactory.createVectorLayer('Australian Beach Walkway','/geo_data/beach_walkway',beachWalkwayStyle)
    @map.addLayer(layer)

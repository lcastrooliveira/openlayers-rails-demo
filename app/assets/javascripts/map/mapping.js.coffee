class @Mapping

  @styleCache: {}

  @iconTypes: {
    'Flag':'010-interface.png',
    'Safety' :'009-shield.png',
    'Tourist Information' :'008-suitcase.png',
    'Utilities' : '007-hammer.png',
    'Food' : '006-restaurant.png',
    'Cultural' : '002-paint.png',
    'Monument': '003-monument.png',
    'Hospital': '004-medical.png',
    'Hotel': '001-sleeping.png',
    'View Spot': '005-watch.png',
  }

  constructor: (@element) ->

  runMap: =>
    osmLayer = LayerFactory.createOSMTileLayer('Map (OSM)')
    bingMapsLayer = LayerFactory.createBingLayer('Satellite')
    center = ol.proj.transform([115.168260,-34.319526],'EPSG:4326','EPSG:3857')
    view = new ol.View({center: center, zoom: 2})
    @map = new ol.Map({
      target: @element.attr('id'),
      loadTilesWhileAnimating: true,
    })
    @map.addLayer(bingMapsLayer)
    @map.addLayer(osmLayer)
    @map.setView(view)

    @popup = new ol.Overlay.Popup()
    @map.addOverlay(@popup)
    @element.data('map', map)

  addLayerSwitcher: =>
    layerSwitcher = new ol.control.LayerSwitcher({
      tipLabel: 'Legenda'
    })
    @map.addControl(layerSwitcher)

  iconStyle = (feature) =>
    return [styleFunction(feature,0.4)]

  selectedSytle = (feature) =>
    return [styleFunction(feature,0.6)]

  styleFunction = (feature,scale) =>
    point_type = feature.get('category')
    key = "#{scale}#{point_type}"
    if(not point_type || not (point_type of Mapping.iconTypes))
      return [MapStyles.defaultPointStyle()]
    if (not Mapping.styleCache[key])
      Mapping.styleCache[key] = MapStyles.getIconStyle(scale,image_path(Mapping.iconTypes[point_type]))
    Mapping.styleCache[key]

  addBeachWalkway: =>
    beachWalkwayStyle = MapStyles.getStrokeStyle([0,153,51,0.8],5)
    layer = LayerFactory.createVectorLayer('Australian Beach Walkway','/geo_data/beach_walkway',beachWalkwayStyle)
    @map.addLayer(layer)

  addBeachWalkwayPoints: =>
    this.setupPointLayers(@map)

  doZoom: (factor) =>
    @map.getView().animate({
      zoom: @map.getView().getZoom() + 12,
      duration: 5500,
      easing: ol.easing.easeOut
    })

  showFeaturePopUp: (feature) =>
    console.log(feature)
    coordinates = feature.getGeometry().getCoordinates()
    @popup.show(coordinates, '<div><h2>' + feature.get('name') + '</h2><p>' + feature.get('description') + '</p></div>')

  addSelectionControls: =>
    selectInteraction = new ol.interaction.Select({
        condition: ol.events.condition.singleClick,
        layers: (layer) ->
          return layer.get('selectable') == true
        style: selectedSytle
    })

    @map.addInteraction(selectInteraction)
    selectedFeatures = selectInteraction.getFeatures()
    selectedFeatures.on('add', (event) =>
      feature = event.target.item(0)
      this.showFeaturePopUp(feature)
    )
    @map.on('pointermove', (event) =>
      mouseCoordInPixels = [event.originalEvent.offsetX, event.originalEvent.offsetY]
      hit = @map.forEachFeatureAtPixel(mouseCoordInPixels,(feature,layer) =>
        return true
      )
      if hit
        @element.css('cursor','pointer')
      else
        @element.css('cursor','')
    )

  setupPointLayers: =>
    $.ajax({
      dataType: "json",
      url: "/geo_data/interest_points",
      success: (data) =>
        features = new ol.format.GeoJSON().readFeatures(data, {featureProjection: 'EPSG:3857'})
        starting_point = null
        features.forEach((feature)=>
          point_type = feature.get('category')
          point_name = feature.get('name')
          if(!starting_point? && point_name = 'Beginning of the trail')
            starting_point = feature
          layer = this.thisLayerExists(point_type)
          if(layer)
            layer.getSource().addFeature(feature)
          else
            layer = new ol.layer.Vector({
                id: point_type
                name: point_type
                title: point_type,
                selectable: true,
                source: new ol.source.Vector({
                    features: [feature]
                }),
                style: iconStyle
            })
            @map.addLayer(layer))
        this.showFeaturePopUp(starting_point)
      error: (e)->
        console.log(e)
    })

  thisLayerExists: (layer_name) =>
    layers = @map.getLayers().getArray()
    layer_ = false
    found = layers.some((layer)->
      if(layer.get('name') == layer_name)
        layer_ = layer
        return true
      else
        return false
    )
    if(found)
      layer_
    else
      false

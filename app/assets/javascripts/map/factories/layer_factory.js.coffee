class @LayerFactory

  @createVectorLayer: (title, source_url, style_object = null) ->
    style_object = MapStyles.getStrokeStyle() if not style_object?

    vectorSource = new ol.source.Vector({
      format: new ol.format.GeoJSON(),
      url: source_url,
      crossOrigin: null
    })
    vectorLayer = new ol.layer.Vector({
        title: title,
        source: vectorSource,
        style: style_object
    })

  @createOSMTileLayer: (title, projection = 'EPSG:3857', crossOrigin = null) ->
    new ol.layer.Tile({
      title: title
      type: 'base'
      source: new ol.source.Stamen({
        layer: 'watercolor'
      }),
      projection: projection,
      crossOrigin: crossOrigin
    })

  @createBingLayer: (title, imagerySet = 'Aerial') ->
    new ol.layer.Tile({
      type: 'base',
      title: title,
      source: new ol.source.BingMaps({
        # Create your key at https://www.bingmapsportal.com
        key: bing_key
        imagerySet: imagerySet
      })
    })

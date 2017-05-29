class @MapStyles

  @defaultPointStyle: () ->
    new ol.style.Style({
      image: new ol.style.Circle({
        radius: 5,
        fill: new ol.style.Fill({
          color: [0,0,255,0.80]
        })
      })
    })

  @getStrokeStyle: (rgba_array = [0,0,0,1.0], stroke_width = 5) ->
    new ol.style.Style({
        stroke: new ol.style.Stroke({
          color: rgba_array,
          width: stroke_width
        })
    })

  @getIconStyle: (scale, path) ->
    new ol.style.Style({
      image: new ol.style.Icon({
        scale: scale
        src: path
      })
    })

$(document).ready ->
  route = $('#map').data('url')
  mapping = new Mapping($('#map'), route)
  mapping.runMap()
  mapping.addBeachWalkwayPoints()
  mapping.addBeachWalkway()
  mapping.addLayerSwitcher()
  mapping.addSelectionControls()
  mapping.doZoom(0.5)

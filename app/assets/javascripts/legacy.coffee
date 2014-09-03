resizeMap = ->
  viewportHeight = document.viewport.getHeight()
  viewportWidth = document.viewport.getWidth()
  map_canvas.style.width = viewportWidth + "px"
  map_canvas.style.height = viewportHeight + "px"
  map.checkResize()  if map

embedMap = ->
  map = new GMap2(map_canvas,
    mapTypes: G_SKY_MAP_TYPES
    backgroundColor: "#000000"
  )
  gLatLng = new GLatLng(-13.5343, 149.104004)
  map.setCenter gLatLng, 13
  map.enableContinuousZoom()
  map.disableInfoWindow()
  map.enableScrollWheelZoom()

addOverlay = ->
  overlay = $("overlay")
  overlay.style.height = document.viewport.getHeight() + "px"
  overlay.style.width = document.viewport.getWidth() + "px"
  Event.observe overlay, "click", ->
    Effect.Fade overlay

addAstrals = ->
  baseAstral = new GIcon(G_DEFAULT_ICON)
  baseAstral.shadow = "about:blank"
  baseAstral.iconSize = new GSize(32, 32)
  baseAstral.shadowSize = new GSize(32, 32)
  baseAstral.iconAnchor = new GPoint(16, 16)
  baseAstral.infoWindowAnchor = new GPoint(16, 16)
  astrals.each (astral) ->
    astralIcon = new GIcon(baseAstral)
    gSize = new GSize(astral.px, astral.px)
    gPoint = new GPoint(astral.px / 2, astral.px / 2)
    astralIcon.iconSize = gSize
    astralIcon.shadowSize = gSize
    astralIcon.iconAnchor = gPoint
    astralIcon.infoWindowAnchor = gPoint
    astralIcon.image = "/assets/img/astrals/" + astral.id + ".png"
    markerOptions = icon: astralIcon
    marker = new GMarker(new GLatLng(astral.lat, astral.lng), markerOptions)
    map.addOverlay marker

panToAstral = (event) ->
  element = event.element()
  astral = element.astral
  gLatLng = new GLatLng(astral["lat"], astral["lng"])
  mapZoom = map.getZoom()
  if astral["zoom"] > mapZoom
    map.zoomIn gLatLng, true, true
  else if astral["zoom"] < mapZoom
    map.zoomOut gLatLng, true, true
  else
    map.panTo gLatLng

enableNavigation = ->
  astrals.each (astral) ->
    astral_element = $(astral["id"] + "_link")
    astral_element.astral = astral
    Event.observe astral_element, "click", panToAstral

map = null
map_canvas = null
overlay = null
astrals = [
  id: "jupiter"
  lat: -13.53594
  lng: 149.100433
  zoom: 13
  px: 600
,
  id: "io"
  lat: -13.592266050160626
  lng: 149.19502838134766
  zoom: 13
  px: 121
,
  id: "europa"
  lat: -13.39814196818416
  lng: 149.1448974609375
  zoom: 13
  px: 105
,
  id: "ganymede"
  lat: -13.540368902382575
  lng: 148.98765563964844
  zoom: 13
  px: 175
,
  id: "callisto"
  lat: -13.659331694429515
  lng: 148.98284912109375
  zoom: 13
  px: 154
 ]
 
Event.observe window, "load", ->
  return false  if GBrowserIsCompatible() is false
  map_canvas = $("map_canvas")
  resizeMap()
  embedMap()
  Event.observe (if document.onresize then document else window), "resize", resizeMap
  addOverlay()
  addAstrals()
  enableNavigation()

Event.observe document, "unload", GUnload
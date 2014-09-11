window.Ent ||= {}
window.Ent.Views ||= {}
window.google ||= {}

#### Map Views
class Ent.Views.Map extends Backbone.View
  className: 'views-map'
  template: _.template('<div id="map-canvas"></div>')

  homeLatLng: new google.maps.LatLng(-13.5343, 149.104004)
  homeZoom: 11

  mapTypeIds: []
  skyMapType:
    getTileUrl: (coord, zoom) ->
      return getHorizontallyRepeatingTileUrl(coord, zoom, (coord, zoom) ->
        return "http://mw1.google.com/mw-planetary/sky/skytiles_v1/" + coord.x + "_" + coord.y + '_' + zoom + '.jpg'
      )
    tileSize: new google.maps.Size(256, 256)
    isPng: false
    maxZoom: 13
    radius: 57.2957763671875
    name: 'Sky'
    credit: 'Image Credit: SDSS, DSS Consortium, NASA/ESA/STScI'
  
  yell: (e) ->
      # console.log @, "#yell", e

  addAstrals: ->
    planetScaleDivider = 500000
    moonScaleDivider = planetScaleDivider / 2
    # console.log(@astrals)
    for a in @astrals
      if a.get('id') in ['jupiter', 'venus', 'fx1']
        scaleDivider =  planetScaleDivider
      else
        scaleDivider = moonScaleDivider
      p1 = new google.maps.LatLng(a.get('lat') - (a.get('d') / scaleDivider), a.get('lng') - (a.get('d') / scaleDivider))
      p2 = new google.maps.LatLng(a.get('lat') + (a.get('d') / scaleDivider), a.get('lng') + (a.get('d') / scaleDivider))
      imageBounds = new google.maps.LatLngBounds(p1, p2)
      imgURL = '/img/astrals/' + a.get('id') + '.png'
      if true
        clickable = false
      else
        clickable = a.get('clickable')
      astral = new google.maps.GroundOverlay(imgURL, imageBounds, {map: @map, clickable: clickable})
      if clickable
        google.maps.event.addListener(astral, 'click', @yell, astral.get('name'))

  isHome: () ->
    return @focusedOn(@homeLatLng)

  focusedOn: (astral) ->

    if _.isFunction(astral.get)
      focus_destination = new google.maps.LatLng astral.get('lat'), astral.get('lng')
    else
      focus_destination = astral

    location = @map.getCenter()

    focus_destination =
      lat: Math.round(focus_destination.lat() * 1000)
      lng: Math.round(focus_destination.lng() * 1000)

    location =
      lat: Math.round(location.lat() * 1000)
      lng: Math.round(location.lng() * 1000)

    focused = (focus_destination.lat is location.lat) and (focus_destination.lng is location.lng)
    console.log @, 'focusedOn', focused, focus_destination.lat, location.lat, focus_destination.lng, location.lng

    return focused

  home: () ->
    @focus(@homeLatLng)
  # A method and system for traveling in space
  focus: (astral) ->

    # Distinguish whether parameter is Ent.Astral or google.maps.LatLng
    if _.isFunction(astral.get)
      # We obtain our @destination and current bounds of the map
      @destination = new google.maps.LatLng astral.get('lat'), astral.get('lng')
      zoom = astral.get('zoom')
    else
      @destination = astral
      zoom = @homeZoom

    if @map.getBounds
      bounds = @map.getBounds()
    else
      console.log 'couldnt get bounds on map: ', @map
      @onFocusCompleted()

      return false

    # These local variables will come in handy inside closures
    map = @map
    self = @
    onFocusCompleted = @onFocusCompleted

    # If the @destination is within bounds, pan and zoom to it
    if bounds? and bounds.contains(@destination)
      @map.panTo(@destination)

      google.maps.event.addListener map, 'idle', ->
        google.maps.event.clearListeners(map, 'idle')
        # We don't want to zoom unless necessary
        #(http://code.google.com/p/gmaps-api-issues/issues/detail?id=4156)
        if map.getZoom() is zoom
          onFocusCompleted()
        else
          google.maps.event.addListener map, 'idle', ->
            google.maps.event.clearListeners(map, 'idle')
            onFocusCompleted()
          map.setZoom(zoom)
    # If not, we want to zoom out far enough to see the @destination, repeat procedure (focusCompleted = false)
    else
      # console.log @, '@destination not in bounds'
      # bounds = new google.maps.LatLngBounds @destination, @map.getCenter()
        
      # Map is inaccessible during load
      if bounds?
        bounds.extend(@destination)

        google.maps.event.addListener map, 'idle', ->
          google.maps.event.clearListeners(map, 'idle')
          self.focus(astral)

        @map.fitBounds bounds
      
      else
        # @focus(astral)        


  embedMap: ->
    # push all mapType keys in to a mapTypeId array to set in the mapTypeControlOptions
    @mapTypeIds['sky'] = @skyMapType
    
    mapOptions =
      backgroundColor: '#000000'
      center: @homeLatLng
      zoom: @homeZoom
      minZoom: 3
      # maxZoom: 13
      disableDefaultUI: true
      keyboardShortcuts: false
      draggable: false
      disableDoubleClickZoom: true
      scrollwheel: false

    @$mapCanvas = @$('#map-canvas').get(0)
    @map = new google.maps.Map(@$mapCanvas, mapOptions)

    # Add the new map type to map.mapTypes
    # and start with the sky map type
    @map.mapTypes.set('sky', new google.maps.ImageMapType(@skyMapType))
    @map.setMapTypeId('sky')

    google.maps.event.addListenerOnce @map, 'idle', =>
      # google.maps.event.clearListeners(@map, 'idle')
      @mapLoaded() if @mapLoaded?

  resize: ->
    google.maps.event.trigger(@map, 'resize')
    
  render: =>
    @$el.html @template()
    @embedMap()
    @addAstrals()
    # @addPlayIcons()
    @
  initialize: (options) ->
    @astrals = options.astrals
    
# Most common entry view
# shows the fuzz
class Ent.Views.Map.Astral extends Backbone.View
  template: _.template('<span class="fuzz"><%= fuzz %></span>')
  className: 'entry'

  events:
    'click': 'editOrDestroy'

  editOrDestroy: (e) =>
    # console.log @, '#editOrDestroy', @model, e
    e.preventDefault()
    if e.shiftKey
      @destroy()
    else
      # @edit

  destroy: ->
    @model.destroy()
    @$el.remove()

  render: =>
    @$el.html @template @model.toJSON()
    @

# Utility function

#Normalizes the tile URL so that tiles repeat across the x axis (horizontally) like the standard Google map tiles.
getHorizontallyRepeatingTileUrl = (coord, zoom, urlfunc) ->
  y = coord.y
  x = coord.x

  # tile range in one direction range is dependent on zoom level
  # 0 = 1 tile, 1 = 2 tiles, 2 = 4 tiles, 3 = 8 tiles, etc
  tileRange = 1 << zoom

  # don't repeat across y-axis (vertically)
  if (y < 0 || y >= tileRange)
    return null

  # repeat across x-axis
  if (x < 0 || x >= tileRange)
    x = (x % tileRange + tileRange) % tileRange

  return urlfunc({x: x, y: y}, zoom)

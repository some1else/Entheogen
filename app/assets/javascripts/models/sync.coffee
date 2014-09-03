# # MM.Sync
# Handles static data and syncing via `JSONP`, implemented in `Ent.Sync.JSONP`
# Reimplements `Backbone.sync` as `Ent.Sync.Core`
Ent.Sync ||= {}

# ## Astrals Sync
Ent.Sync.Astrals = (method, model, options) ->
  result = [
    id: 'jupiter'
    name: 'Jupiter'
    ra: '3h 48m 12s'
    dec: '19° 11\' 45"'
    lat: -13.53594
    lng: 149.100433
    astral: true
    zoom: 8
    px: 600
    d: 69911
    clickable: true
    audio_src: '/mp3/entheogen-jupiter.mp3'
    audio_length: '05:09'
    soundcloud_href: 'http://soundcloud.com/entheogenband/jupiter-demo'
    soundcloud_embed: '<object height="81" width="100%"> <param name="movie" value="https://player.soundcloud.com/player.swf?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F40891101&amp;show_comments=false&amp;auto_play=true&amp;color=000000"></param> <param name="allowscriptaccess" value="always"></param> <embed allowscriptaccess="always" height="81" src="https://player.soundcloud.com/player.swf?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F40891101&amp;show_comments=false&amp;auto_play=true&amp;color=000000" type="application/x-shockwave-flash" width="100%"></embed> </object>'
  ,
    id: "io"
    name: "Io"
    member_info: 'Matija Bencik ~ 6 string'
    ra: '3h 48m 19s'
    dec: '19° 12\' 6"'
    lat: -13.592266050160626
    lng: 149.19502838134766
    astral: true
    zoom: 12
    px: 121
    d: 1821
    clickable: true
    audio_src: '/mp3/entheogen-io.mp3'
    audio_length: '05:10'
    fact: '<b>Average radius:</b> 1821.6 km'
    facts: [
      'average distance from Earth': '43.7 light minutes'
      'orbital period': '42.46 h'
      'mass': '8.9298×10^22 kg'
      'average radius': '1821.6 km'
      'rotation period': '42.46 h'
      'discoverer': 'Galileo Galilei'
      'discovery year': '1610'
      'equatorial location': 'Ra 3h 46m 31s, dec 19° 6\' 19\"'
      'altitude': '-22° 40\'  (below horizon)'
      'azimuth': '18° 9\' (NNE)'
      'constellation': 'Taurus'
      'actovity': 'most volcanically active'
    ]
  ,
    id: "europa"
    name: 'Europa'
    member_info: 'Matic Kadliček ~ 2 sticks - 3 pedals'
    ra: '3h 48m 19s'
    dec: '19° 12\' 6"'
    lat: -13.39814196818416
    lng: 149.1448974609375
    astral: true
    zoom: 12
    px: 105
    d: 1569
    clickable: true
    audio_src: '/mp3/entheogen-europa'
    audio_length: '05:19'

  ,
    id: "ganymede"
    name: "Ganymede"
    member_info: 'Matej Voglar ~ 7 string : samples'
    ra: '3h 48m 19s'
    dec: '19° 12\' 6"'
    lat: -13.540368902382575
    lng: 148.98765563964844
    astral: true
    left: true
    zoom: 12
    px: 175
    d: 2634
    clickable: true
    audio_src: '/mp3/entheogen-ganymede'
    audio_length: '06:00'
  ,
    id: 'callisto'
    name: 'Callisto'
    member_info: 'Sergej Žižek ~ 5 string'
    ra: '3h 48m 19s'
    dec: '19° 12\' 6"'
    lat: -13.659331694429515
    lng: 148.98284912109375
    astral: true
    left: true
    px: 154
    d: 2410
    zoom: 12
    clickable: true
    audio_src: '/mp3/entheogen-callisto.mp3'
    audio_length: '05:45'
    soundcloud_href: 'http://soundcloud.com/entheogenband/callisto'
    soundcloud_embed: '<object height="81" width="100%"> <param name="movie" value="https://player.soundcloud.com/player.swf?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F40890882&amp;show_comments=false&amp;auto_play=true&amp;color=000000"></param> <param name="allowscriptaccess" value="always"></param> <embed allowscriptaccess="always" height="81" src="https://player.soundcloud.com/player.swf?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F40890882&amp;show_comments=false&amp;auto_play=true&amp;color=000000" type="application/x-shockwave-flash" width="100%"></embed> </object>'
  ,
    id: 'venus'
    name: 'Venus'
    ra: '4h 53m 22s'
    dec: '22° 16\' 48"'
    lat: 24.5377777777778
    lng: -104.768333333333
    astral: true
    zoom: 12
    px: 300
    d: 6051
    clickable: true
    audio_src: '/mp3/entheogen-venus.mp3'
    audio_length: '06:17'
    soundcloud_href: 'http://soundcloud.com/entheogenband/venus-demo'
    soundcloud_embed: '<object height="81" width="100%"> <param name="movie" value="https://player.soundcloud.com/player.swf?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F40891381&amp;show_comments=false&amp;auto_play=true&amp;color=000000"></param> <param name="allowscriptaccess" value="always"></param> <embed allowscriptaccess="always" height="81" src="https://player.soundcloud.com/player.swf?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F40891381&amp;show_comments=false&amp;auto_play=true&amp;color=000000" type="application/x-shockwave-flash" width="100%"></embed> </object>'
  ,
    id: "string-of-pearls"
    name: "String of Pearls"
    member_info: ''
    ra: ''
    dec: ''
    display_celestial_coords: false
    lat: -13.682266050160626
    lng: 149.24202838134766
    astral: true
    zoom: 12
    px: 300
    d: 27821
    clickable: true
    audio_src: '/mp3/entheogen-string-of-pearls.mp3'
    audio_length: '05:10'
    fact: '<b>Average radius:</b> 1821.6 km'
  ,
    id: 'sun'
    astral: false
    ra: '5h 5m 34s'
    dec: ' 22° 50\' 54"'
  ,
    id: 'fx1'
    name: 'modr flek'
    lat: -13.696411722388972
    lng: 148.9437889099121
    astral: true
    px: 400
    d: 10000
  ]
  Ent.Sync.Static(method, model, options, result)

# ## Static Sync
# Forwards the `result` data to `options.success` function
Ent.Sync.Static = (method, model, options, result) ->
  options.success(result)


# ## JSONP Sync
#
# This method decorates the sync request with `JSONP` relevant options and proxies to `CoreSync`
#
# Timeout is required for 404 responses because of `JSONP` and a custom callback name (`json_callback`) is used so the server can identify `JSONP` requests
Ent.Sync.JSONP = (method, model, options) ->
  options.dataType = 'jsonp'
  options.timeout = 10000 
  # `jQuery.ajax` uses this to define the `callback` name
  options.jsonp = 'json_callback'
  # `jQuery.jsonp` uses this to define the `callback` name
  options.callbackParameter = 'json_callback'
  options.callback = '_jqjsp'
  Ent.CoreSync(method, model, options)


# ## Core Sync
#
# Reimplementation of `Backbone.Sync` to handle some exceptions where `sync` proxies want to set `params.data` to something other than `model.toJSON()`
#
# `Backbone.Sync` will undo `options.processData` depending on the `method` of the request and the `Backbone.emulateJSON` option. This might have other implications though. This is the thing to look at if `params.data` isn't being evaluated or escaped properly.
Backbone.emulateJSON = true

Ent.Sync.Core = (method, model, options) ->
  type = methodMap[method]
  params =
    type: type
    dataType: "json"
  params.url = getValue(model, "url") or urlError()  unless options.url
  # `params.data` shouldn't be set if we have `options.data` to work with
  if not options.data and model and (method is "create" or method is "update")
    params.contentType = "application/json"
    params.data = JSON.stringify(model.toJSON())
  if Backbone.emulateJSON
    params.contentType = "application/x-www-form-urlencoded"
    params.data = (if params.data then model: params.data else {})
  if Backbone.emulateHTTP
    if type is "PUT" or type is "DELETE"
      params.data._method = type  if Backbone.emulateJSON
      params.type = "POST"
      params.beforeSend = (xhr) ->
        xhr.setRequestHeader "X-HTTP-Method-Override", type
  # `processData` shoudn't be false if we have `Backbone.emulateJSON` enabled
  params.processData = false  if params.type isnt "GET" and not Backbone.emulateJSON
  combined = _.extend(params, options)
  # We use `$.jsonp` instead of `$.ajax` due to it's improved `JSONP` error handling
  $.jsonp combined

# Utility for resolving `method` to `HTTP` verbs
methodMap =
  'create': 'POST'
  'update': 'PUT'
  'delete': 'DELETE'
  'read'  : 'GET'
# Utility for retrieving any `Backbone` object property either as a method or an attribute
getValue = (object, prop) ->
  return null  unless object and object[prop]
  (if _.isFunction(object[prop]) then object[prop]() else object[prop])
# Utility for throwing an `Error` if no `URL` is specified
urlError = ->
  throw new Error("A 'url' property or function must be specified")
# # Entheogen App Router

window.Ent ||= {}
Ent.Views ||= {}

# Responds to `routes` and instantiates appropriate `Views`
class Ent.App extends Backbone.Router
  routes:
    '/'                  : 'index'

    'about'             : 'about'
    'events'            : 'events'
    'music'             : 'music'
    'play/:id'          : 'play'
    'videos'            : 'videos'
    'photos'            : 'photos'
    'contact'           : 'contact'
  
  # ## Initialize
  #
  # + Assigning the `DOM` elements to local variables
  # + Initializing `Nav`
  # + Initializing `Map`
  # + Initializing `Crosshairs`
  initialize: ->
    @initCollections()

    @assignDOMElements()

    # @initApp()
    @initNav()
    @initMap()
    @initCrosshairs()
    console.log 'lol'
    @initTransitionEnd()
    @initPlayers()
    @initUI()

    @initSkrollr()

  # ## Index
  #
  # * doesn't do anything
  index: ->
    console.log 'here i am'
    @view.destroy() if @view and @view.destroy

    @view = new Ent.Views.Index()
    @$app.html @view.render().el
    # @updateCrosshairs 1, 1, 1, 1

    @updateCrosshairs 0, 0, 0, 0

    if @map.isHome()
      @$app.html @view.render().el
      @view.activate()
    else
      map = @map
      $app = @$app
      currentView = @view
      @map.onFocusCompleted = ->
        $app.html currentView.render().el
        currentView.activate()
        delete map.onFocusCompleted
      @map.home()

  # ## About
  # Contains story and concept of the band
  about: ->
    @view.destroy() if @view and @view.destroy

    @view = new Ent.Views.About()

    @updateCrosshairs 0, 0, 0, 0

    if @map.isHome()
      @$app.html @view.render().el
      @view.activate()
    else
      map = @map
      $app = @$app
      currentView = @view
      @map.onFocusCompleted = ->
        $app.html currentView.render().el
        currentView.activate()
        delete map.onFocusCompleted
      @map.home()

  # ## Play
  # Audio files in space
  play: (id) ->

    @view.destroy() if @view and @view.destroy

    track = @astrals.get(id)

    @view = new Ent.Views.Player(model: track)

    if track.get('left')
      @updateCrosshairs 1, 1, 1, 0
    else  
      @updateCrosshairs 1, 0, 1, 1

    if @map.focusedOn(track)
      @$app.html @view.render().el
      @view.activate()
      @updateTitle(track.get('name'))
    else
      map = @map
      $app = @$app
      currentView = @view
      app = @
      @map.onFocusCompleted = ->
        $app.html currentView.render().el
        currentView.activate()
        app.updateTitle(track.get('name'))
        delete map.onFocusCompleted
      @map.focus track

  # ## Redirect
  # When the user arrives to the root path, they're redirected depending on whether they're logged in or not
  redirect: ->
    @navigate('', true)

  # ## Document Title changes just like History API
  updateTitle: (title)->
    document.title = title + ' | ENTHEOGEN'

  # ## Utility Methods

  # Initializes collections
  initCollections: ->
    # @tracks = new Ent.Tracks()
    # @tracks.fetch()
    @astrals = new Ent.Astrals()
    @astrals.fetch()
    # console.log @, '#initCollections', 'created', @astrals

  # `App` resizing
  initApp: ->
    @resizeApp()
    $(window).on('resize', @resizeApp)

  resizeApp: =>
    console.log "LOL"
    @$app.height($(window).height() - @$nav.height())
    # @$app.width($(window).width() - @$nav.width())

  # `Xhairs`
  initCrosshairs: ->
    @crosshairs = new Ent.Views.Crosshairs
    @$xhr.html @crosshairs.render().el

  updateCrosshairs: (top, right, bottom, left) ->
    @crosshairs.update top, right, bottom, left

  # `Nav` view
  initNav: ->
    @nav = new Ent.Views.Nav()
    @$nav.html @nav.render().el
    @nav.postRender()

  # `Map` view
  initMap: ->
    astrals = _.filter(@astrals.models, (a) ->
      a.get('astral') == true
    )
    @map = new Ent.Views.Map(astrals: astrals)
    @$map.html @map.render().el
    @resizeMap()
    $(window).on('resize', @resizeMap)

  resizeMap: =>
    viewportHeight = $(window).height()
    viewportWidth = $(window).width() 
    @$map.width(viewportWidth)
    @$map.height(viewportHeight)
    if @map?
      @map.resize()
      if @map.destination?
        unless @map.focusedOn(@map.destination)
          @map.focus @map.destination


  # Hides the players
  initPlayers: ->
    $('.ui360').hide()

  # This triggers the intro animations
  initUI: ->
    @$nav.addClass 'active'
    @$xhr.addClass 'active'

  initSkrollr: ->
    @skrollr ||= skrollr.init(smoothScrolling: true, forceHeight: false)


  # Local variables for easy, cached access
  assignDOMElements: ->
    @$app = $('#app')
    @$nav = $('#nav')
    @$map = $('#map')
    @$xhr = $('#crosshairs')

  initTransitionEnd: ->
    @transitionEnd = @determineTransitionEnd()

  # Utility function for determining transitionEnd API
  determineTransitionEnd: -> 
    el = document.createElement('fakeelement')
    transitions = {
      'transition':'transitionEnd',
      'OTransition':'oTransitionEnd',
      'MSTransition':'msTransitionEnd',
      'MozTransition':'transitionend',
      'WebkitTransition':'webkitTransitionEnd'
    }

    for t in transitions
      if el.style[t] != undefined
        return transitions[t]

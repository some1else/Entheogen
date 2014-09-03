window.Ent ||= {}
window.Ent.Views ||= {}

class Ent.Views.Player extends Backbone.View
  className: 'player-view'
  memberFactTemplate: _.template('<div class="wrap">
                                    <div class="radec">Ra <%= ra %>, dec <%= dec %></div>
                                    <div class="name"><%= name %></div>
                                    <div class="member"><%= member_info %></div>
                                    <div class="fact"><%= fact %></div>
                                  </div>
  ')
  factTemplate:       _.template('<div class="wrap">
                                    <div class="radec">Ra <%= ra %>, dec <%= dec %></div>
                                    <div class="name"><%= name %></div>
                                    <div class="fact"><%= fact %></div>
                                  </div>
  ')
  memberTemplate:     _.template('<div class="wrap">  
                                    <div class="radec">Ra <%= ra %>, dec <%= dec %></div>
                                    <div class="name"><%= name %></div>
                                    <div class="member"><%= member_info %></div>
                                  </div>
  ')
  simpleTemplate:     _.template('<div class="wrap">
                                    <div class="radec">Ra <%= ra %>, dec <%= dec %></div>
                                    <div class="name"><%= name %></div>
                                  </div>
  ')  
  nameTemplate:     _.template('<div class="wrap">
                                    <div class="name long-name"><%= name %></div>
                                  </div>
  ')
  

  render: =>
    if @model.get('member_info')
      @$el.html @memberTemplate(@model.toJSON())
    else
      if @model.get('display_celestial_coords') isnt false
        @$el.html @simpleTemplate(@model.toJSON())
      else
        @$el.html @nameTemplate(@model.toJSON())

    if @model.get('left') != true
      @$el.addClass('player-view-right')
    else
      @$el.addClass('player-view-left')

    @$player.addClass('ui360-playing')
    @$player.show()

    @

  activate: =>
    @$el.addClass('active')
    console.log('active')
  destroy: =>
    @$player.hide()
    @$el.removeClass('active')
    @$el.addClass('destroyed')

  initialize: (options) ->
    selector = '#music #player_' + options.model.get('id')
    @$player = $(selector)
    # console.log @, '#init', selector, @$player

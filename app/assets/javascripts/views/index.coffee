window.Ent ||= {}
window.Ent.Views ||= {}

# `Index` shows the Jupiter and it's moons
class Ent.Views.Index extends Backbone.View
  template: _.template("")
  id: 'index-view'

  initialize: ->
    console.log @, 'initialize'

  render: ->
    @$el.html @template()
    @

  activate: ->
    @$el.addClass('active')
  destroy: ->
    @$el.removeClass('active')
    @$el.addClass('destroyed')
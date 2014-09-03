window.Ent ||= {}
window.Ent.Views ||= {}

class Ent.Views.Bandpage extends Backbone.View
  template: _.template("")
  className: 'bandpage-view'

  activate: =>
    @$el.addClass('active')
  destroy: ->
    @$el.removeClass('active')
    @$el.addClass('destroyed')


  render: =>
    @$el.html @template()
    @
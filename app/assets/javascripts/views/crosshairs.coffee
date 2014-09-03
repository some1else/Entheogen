window.Ent ||= {}
window.Ent.Views ||= {}

class Ent.Views.Crosshairs extends Backbone.View
  template: _.template("<div id='top'></div> <div id='right'></div> <div id='bottom'></div> <div id='left'></div>")

  render: ->
    @$el.html @template()
    @

  update: (top, right, bottom, left) ->
    @initDOMElements()
    
    console.log @, 'update', 'OHAi', @$top
    if top == 1
      @$top.addClass('visible') unless @$top.hasClass('visible')
    else
      @$top.removeClass('visible') if @$top.hasClass('visible')

    if right == 1
      @$right.addClass('visible') unless @$right.hasClass('visible')
    else
      @$right.removeClass('visible') if @$right.hasClass('visible')

    if bottom == 1
      @$bottom.addClass('visible') unless @$bottom.hasClass('visible')
    else
      @$bottom.removeClass('visible') if @$bottom.hasClass('visible')

    if left == 1
      @$left.addClass('visible') unless @$left.hasClass('visible')
    else
      @$left.removeClass('visible') if @$left.hasClass('visible')



  initDOMElements: ->
    @$top ||= @$('#top')
    @$right ||= @$('#right')
    @$bottom ||= @$('#bottom')
    @$left ||= @$('#left')
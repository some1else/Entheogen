window.Ent ||= {}
window.Ent.Views ||= {}

class Ent.Views.PlayerNav extends Backbone.View
  # id: 'views-player_navbar'
  className: 'player_navbar'
  template: _.template("  <ul class='center music nav fresh'>
                            <li class='venus'><a href='/play/venus'>Venus</a></li>
                            <li class='string-of-pearls'><a href='/play/string-of-pearls'>String of Pearls</a></li>
                            <li class='jupiter'><a href='/play/jupiter'>Jupiter</a></li>
                            <li class='io'><a href='/play/io'>Io</a></li>
                            <li class='europa'><a href='/play/europa'>Europa</a></li>
                            <li class='ganymede'><a href='/play/ganymede'>Ganymede</a></li>
                            <li class='callisto'><a href='/play/callisto'>Callisto</a></li>
                          </ul>
                        ")

  events:
    'click .music a': 'gotoMusic'

  gotoMusic: (e) =>
    @makeStale()
    
    console.log @, 'gotoMusic'

    e.preventDefault()

    @activateLink(e.target)
    
    href = e.target.href
    id = href.substr(href.lastIndexOf('/') + 1, href.length)
    
    Ent.app.navigate('play/' + id, trigger: true)

  activateLink: (activeLink) ->
    @$links.each (i, link) ->
      if link is activeLink
        link.className = 'music-link active'
      else
        link.className = 'music-link'

  render: =>
    @$el.html @template()
    # setTimeout(@makeStale, 2000)
    # @makeStale()
    @

  postRender: ->
    @$links = @$('a')

  makeStale: =>
    @$('ul').removeClass('fresh')


window.Ent ||= {}
window.Ent.Views ||= {}

class Ent.Views.Nav extends Backbone.View
  # id: 'views-navbar'
  className: 'navbar'
  template: _.template("  <ul class='left music nav fresh'>
                            <li class='moons-of-jupiter local'><a href='#moons-of-jupiter'>Moons of Jupiter</a></li>
                            <li class='events local'><a href='#events'>Events</a></li>
                            <li class='materials local'><a href='#materials'>Materials</a></li>
                            <li class='visuals local'><a href='#visuals'>Visuals</a></li>
                            <li class='entheogenesis local'><a href='#entheogenesis'>Entheogenesis</a></li>
                          </ul>
                          <div class='right about nav fresh'>
                            <h1 class='entheogen'><a href='/'>Entheogen</a></h1>
                          </div>
                        ")

  events:
    'hover .entheogen a': 'firstHover'
    'click .local a': 'localLink'
    'click .entheogen a': 'showContent'


  firstHover: (e) =>
    return if $('body').scrollTop() != 0
    $('body').animate({scrollTop: $('.right').height() - 40}, 333)
    @hoveredBefore = true

  localLink: (e) =>
    e.preventDefault()
    @activateLink(e.target)

    id = e.currentTarget.href
    id = id.substr(id.indexOf('#'), id.length)
    newTop = $(id).position()?.top || 0
    newTop = newTop - 40
    $('body').animate({scrollTop: newTop}, 333)

  showContent: (e) =>
    e.preventDefault()
    @activateLink(e.target)
    $('body').animate({scrollTop: 0}, 333)
    Ent.app.navigate('', trigger: true)
    Ent.app.index()

  gotoIndex: (e) =>
    @makeStale()

    e.preventDefault()

    @activateLink(e.target)

    Ent.app.navigate('', trigger: true)

  gotoAbout: (e) =>
    @makeStale()

    console.log @, 'gotoAbout'

    e.preventDefault()

    @activateLink(e.target)

    Ent.app.navigate('about', trigger: true)

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


window.Ent ||= {}
window.Ent.Views ||= {}

class Ent.Views.Nav extends Backbone.View
  # id: 'views-navbar'
  className: 'navbar'
  template: _.template("  <ul class='left music nav fresh'>
                            <li class='venus'><a href='/play/venus'>Venus</a></li>
                            <li class='string-of-pearls'><a href='/play/string-of-pearls'>String of Pearls</a></li>
                            <li class='jupiter'><a href='/play/jupiter'>Jupiter</a></li>
                            <li class='io'><a href='/play/io'>Io</a></li>
                            <li class='europa'><a href='/play/europa'>Europa</a></li>
                            <li class='ganymede'><a href='/play/ganymede'>Ganymede</a></li>
                            <li class='callisto'><a href='/play/callisto'>Callisto</a></li>
                          </ul>
                          <div class='right about nav fresh'>
                            <h1 class='entheogen'><a href='/'>Entheogen</a></h1>
                            <ul class='content-submenu'>
                              <li class='events local'><a href='#events'>Events</a></li>
                              <li class='materials local'><a href='#materials'>Materials</a></li>
                              <li class='visuals local'><a href='#visuals'>Visuals</a></li>
                              <li class='entheogenesis local'><a href='#entheogenesis'>Entheogenesis</a></li>
                            </ul>
                            <ul class='social-submenu'>
                              <li class='youtube'><a title='YouTube' target='_blank' href='http://www.youtube.com/user/3nth30g3n'><span class='initial'>Y</span><span class='remainder'>ouTube</span></a></li>
                              <li class='facebook'><a title='Facebook' target='_blank' href='https://www.facebook.com/pages/Entheogen/70202543407'><span class='initial'>F</span><span class='remainder'>acebook</span></a></li>
                              <li class='reverbnation'><a title='ReverbNation' target='_blank' href='http://reverbnation.com/entheogenband'><span class='initial'>R</span><span class='remainder'>everbNation</span></a></li>
                              <li class='bandcamp'><a title='Bandcamp' target='_blank' href='http://entheogenband.bandcamp.com/'><span class='initial'>B</span><span class='remainder'>ouTube</span></a></li>
                            </ul>
                          </div>
                        ")

  events:
    'hover .entheogen a': 'firstHover'
    'click .local a': 'localLink'
    'click .entheogen a': 'showContent'
    'click .music a': 'gotoMusic'


  firstHover: (e) =>
    return if $('body').scrollTop() != 0
    $('body').animate({scrollTop: $('.right').height() - 40}, 333)
    @hoveredBefore = true

  localLink: (e) =>
    e.preventDefault()
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

  gotoMusic: (e) =>
    @makeStale()
    
    console.log @, 'gotoMusic'

    e.preventDefault()

    @activateLink(e.target)
    
    href = e.target.href
    id = href.substr(href.lastIndexOf('/') + 1, href.length)
    
    Ent.app.navigate('play/' + id, trigger: true)

  gotoIndex: (e) =>
    @makeStale()

    e.preventDefault()

    @activateLink(e.target)

    Ent.app.navigate('/', trigger: true)

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
    console.log('YO')


window.Ent ||= {}

class Ent.Session extends Backbone.Model
  defaults:
      login: ''
      pass: ''
      token: '', real_name: '', account: ''

  sync: Ent.Sync.Session

  url: ->
    Ent.Sync.URL + '/api/login/' + @get('login')

  saveToCookie: ->
    cookieData = JSON.stringify
      account: @get('account')
      real_name: @get('real_name')
      token: @get('token')

    $.cookie 'EntSessionData', cookieData, {path: '/', expires: 14}

  loadFromCookie: ->
    cookieData = $.cookie 'EntSessionData'

    if (cookieData isnt null)
      cookieData = JSON.parse(cookieData)
      @set(cookieData, silent: true)

  isLoaded: ->
    @get('token') != '' && @get('account') != '' && @get('real_name') != ''

  deleteCookie: ->
    $.cookie 'EntSessionData', null
    
  tokenChanged: ->
    @saveToCookie() if @isLoaded()

  initialize: ->
    @loadFromCookie()
    @on 'change:token', @tokenChanged
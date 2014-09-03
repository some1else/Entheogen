window.Ent ||= {}

class Ent.Track extends Backbone.Model
  defaults:
      id: ''
      name: ''
      href: ''
      embed: ''
      lat: ''
      lng: ''

class Ent.Tracks extends Backbone.Collection
  sync: Ent.Sync.Tracks
  model: Ent.Track

window.Ent ||= {}

class Ent.Astral extends Backbone.Model
  defaults:
      id: ''
      name: ''
      lat: ''
      lng: ''
      astral: false
      zoom: ''
      px: ''  # pixel width
      d: ''   # diamter~
      audio_src: ''
      soundcloud_href: ''
      soundcloud_embed: ''

class Ent.Astrals extends Backbone.Collection
  sync: Ent.Sync.Astrals
  model: Ent.Astral

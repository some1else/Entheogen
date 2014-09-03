window.Ent ||= {}
window.Ent.Views ||= {}

class Ent.Views.About extends Backbone.View
  template: _.template("<p>Approximately four years ago two planetoids - one from a stoner rock group called MG Pistol Rock, the other from a math/post rock group called Imakandi - collided and melted all but their metal core. The result is Entheogen - a homogenous mixture of math/sludge with a pinch of post- and stoner rock. After years of evolution, erosion and gigabytes of organized noise enough matter had broken away from the moons to create a debut album, scheduled to see its first sunrise in the first half of 2012.</p>
    <p>The creative process converted the resulting friction into energy for Moons of Jupiter - a thematic album dedicated to the STS-34 mission - the spacecraft Galileo (named after the first observer of Jupiter's moons, described in his Siderius Nuncius from 1610) that was launched on its path from Earth to the gas giant in 1989. The music represents an attempt of a sonic rendering of the mission and is therefore different from phase to phase. The basis remains instrumental math/sludge with influences from bands like Neurosis, Meshuggah, Pelican, Alice in Chains and the like.</p>")
  className: 'about-view'

  activate: =>
    @$el.addClass('active')
  destroy: ->
    @$el.removeClass('active')
    @$el.addClass('destroyed')


  render: =>
    @$el.html @template()
    @
React = require 'react'
{div, button, span, p, img, ul, li} = require 'reactionary'

module.exports = React.createClass
  getInitialState: ->
    showRuler: true
    unit: 'inch'
    loadedMetric: false

  propTypes:
    model: React.PropTypes.object.isRequired
    imgSize: React.PropTypes.string.isRequired

  handleUnitClick: (e) ->
    unit = e.target.value
    if e.preventDefault
      e.preventDefault()
    @setState unit: unit

  loadMetricRuler: ->
    unless @state.loadedMetric
      item = @props.model
      img = new Image()
      img.src = item.rulerPath.cm[@props.imgSize]
      @setState loadedMetric: true
      console.log 'prefetch metric ruler'

  render: ->
    item = @props.model
    unit = @state.unit
    inchesClass = 'ruler-inches'
    cmClass = 'ruler-cm'
    if unit == 'cm'
      imgClass = cmClass
      cmClass += ' active'
    else
      imgClass = inchesClass
      inchesClass += ' active'

    imgPath = item.rulerPath[unit][@props.imgSize]

    els = [] #elements
    # Ruler toggle.
    els.push ul
      key: 'ruler-toggle'
      className: 'ruler-toggle',
        li
          className: inchesClass,
            button
              type: 'button'
              value: 'inch'
              onClick: @handleUnitClick
              className: 'uppercase',
                'Inches'
        li
          className: cmClass,
            button
              type: 'button'
              value: 'cm'
              onClick: @handleUnitClick
              onHover: @loadMetricRuler
              className: 'uppercase',
              'Centimeters'
    # Ruler image.
    els.push div
      key: 'rulers'
      className: 'rulers',
        img
          className: imgClass
          src: imgPath
          alt: imgClass

    return div className: 'ruler-wrap hidden-xs',
      els

React = require 'react'
{div, p, ul, li, button, img, i} = require 'reactionary'

module.exports = React.createClass
  getInitialState: ->
    buttonsFor: ''
    windowWidth: window.innerWidth

  setButtonsFor: (e) ->
    unless @props.threeUp
      @setState buttonsFor: e.target.id

  colorsClick: (e) ->
    if 'passementerie' == @props.initState.category
      if @props.initState.patternNumber
        @props.setRouterState
          patternNumber: false
      else
        @props.setRouterState
          patternNumber: e.target.value

  render: ->
    list = []
    if @props.threeUp
      buttonsFor = @props.collection.models[1].id
    else
      buttonsFor = @state.buttonsFor
    imgSize = 'small'
    # List
    @props.collection.forEach (item, index) =>
      if buttonsFor == item.id
        buttons = []
        if @props.extraButtons
          buttons.push button
            key: 'colors'
            value: item.patternNumber
            onClick: @colorsClick
            className: 'item-colors',
              'Colors'
        buttons.push button
          key: 'favs'
          className: 'item-favorite',
            '+'
        if @props.extraButtons
          buttons.push button
            key: 'details'
            className: 'item-details',
              '='
        # Action buttons
        buttons = div
          className: 'item-icons hidden-xs',
            buttons
      else
        buttons = ''

      list.push li
        key: item.id,
          # Image
          img
            id: item.id
            width: item._file[imgSize].width
            height: item._file[imgSize].height
            src: item._file[imgSize].path,
            onMouseOver: @setButtonsFor
          buttons


    return div
      className: 'pg-size-' + @props.initState.pgSize
      id: 'collection-' + @props.initState.category,
        ul
          className: 'list',
            list

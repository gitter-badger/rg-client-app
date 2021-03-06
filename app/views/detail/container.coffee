React = require 'react'
{div, table, tbody, tr, td, button, h3, p, span} = require 'reactionary'

HeaderBar = require './header'
Switcher = require './buttons'
FavAlertBox = require '../el/fav_alert'
ProjectBox = require '../el/project_box'

module.exports = React.createClass
  getInitialState: ->
    isRelated: false
    favBoxView: false
    projectBoxView: false
    windowWidth: window.innerWidth

  handleResize: (e) ->
    ww = window.innerWidth
    if ww % 5 == 0
      @setState windowWidth: ww

  componentDidMount: ->
    window.addEventListener 'resize', @handleResize

  componentWillUnmount: ->
    window.removeEventListener 'resize', @handleResize

  handleUserInput: (newSt) ->
    if newSt.color_id
      newSt.isRelated = true
      @props.setRouterState
        color_id: newSt.color_id
    @setState newSt

  loadRelatedImgs: ->
    @props.collection.each (item) ->
      itemImg = new Image()
      itemImg.src = item._file.small.path

  componentWillMount: ->
    # Begin downloading all related images in small 640px.
    @loadRelatedImgs()

  render: ->
    ops = @props.initState
    id = ops.patternNumber + '-' + ops.color_id
    item = @props.collection.get id
    unless item
      console.log @props.collection.models

    props =
      model: item
      initState: @props.initState
      collection: @props.collection
      pageIndex: @state.pageIndex
      onUserInput: @handleUserInput
      isRelated: @state.isRelated
      patternNumber: ops.patternNumber
      windowWidth: @state.windowWidth
      itemState: @state
      activeId: id

    if @state.projectBoxView == item.id
      favAlert = ProjectBox
        itemState: @state
        setItemState: (st) => @setState st
        model: item
    else if @state.favBoxView == item.id
      favAlert = FavAlertBox
        itemState: @state
        model: item
        setItemState: (st) => @setState st
    else
      favAlert = false

    div
      id: 'container-detail'
      className: 'item-detail '+item.category,
        HeaderBar props
        favAlert
        Switcher props

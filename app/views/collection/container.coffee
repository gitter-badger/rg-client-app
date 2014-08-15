React = require 'react'
{p, div, ul, li, button} = require 'reactionary'

Row = require './row'

module.exports = React.createClass
  getInitialState: ->
    buttonsFor: @props.buttonsForInit
    searchTxt: @props.initState.searchTxt
    pageSize: @props.initState.pageSize
    pageIndex: @props.initState.pageIndex

  render: ->
    category = @props.initState.category
    p
      className: 'text-area',
        'Browse the collection by category below.'
    div
      className: 'collection',
        Row
          active: 'textile' == category
          category: 'textile'
          label: 'Textiles'
          collection: @props.collection
          initState: @props.initState
        Row
          active: 'passementerie' == category
          category: 'passementerie'
          collection: @props.collection
          initState: @props.initState
        Row
          active: 'leather' == category
          category: 'leather'
          collection: @props.collection
          initState: @props.initState
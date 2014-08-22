React = require 'react'
{p, h3, div, ul, li, label, input} = require 'reactionary'
_ = require 'lodash'
SubCollection = require 'ampersand-subcollection'

Items = require './collection/items'

module.exports = React.createClass

  render: ->
    v = @props.initState

    favsMenu = ul
      className: 'favs-menu',
        li
          className: 'share',
            label
              className: 'uppercase'
              htmlFor: 'share-field',
                'Share: '
            input
              id: 'share-field'
              type: 'text'
              value: 'http://fav.rogersandgoffigon.com/'
              readOnly: true
        li
          h3
            className: 'uppercase',
              'Favorites'

    if v.ids and v.ids.length
      content = []
      favs = @props.collection
      categories = ['textile', 'leather', 'passementerie']
      categories.forEach (cat) =>
        items = new SubCollection(favs, where: category: cat)
        if items.length
          props =
            collection: items
            key: cat
            category: cat
            extraButtons: 'passementerie' == cat
          content.push Items _.extend(@props, props)
    else
      content = p 'No favorites found.'

    div
      id: 'container-favs',
        p
          key: 'intro'
          className: 'text-area',
            'Browse and edit your favorites.'
        favsMenu
        content

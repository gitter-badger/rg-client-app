React = require 'react'
{form, input, p, div, button, select, option, ul, li, a} = require 'reactionary'

# props
## onUserInput() - defined in item_container.

module.exports = React.createClass
  handleChange: (event) ->
    @props.onUserInput
      searchTxt: @refs.filterTextInput.getDOMNode().value
      summerSale: @refs.summerSale.getDOMNode().checked
      pageSize: @refs.setPageSize.getDOMNode().value

  handleCollectionClick: (e) ->
    collection_id = e.target.value
    if e.preventDefault
      e.preventDefault()
    @props.onUserInput category: collection_id

  render: ->
    v = @props.filter # see item_container.coffee for example object.
    div {},
      form {},
        input
          type:'text',
          placeholder:'Search...',
          value: v.searchTxt,
          ref:'filterTextInput',
          onChange: @handleChange
        select
          ref: 'setPageSize'
          value: v.pageSize
          onChange: @handleChange
          type: 'select',
            option
              value: '50'
              '50'
            option
              value: '100'
              '100'
            option
              value: '10000'
              'All'
        div {},
          button
            className: if (v.category == 'textile') then 'active'
            onClick: @handleCollectionClick
            value: 'textile',
            'Textiles'
          button
            className: if (v.category == 'passementerie') then 'active'
            onClick: @handleCollectionClick
            value: 'passementerie',
            'Passementerie'
          button
            className: if (v.category == 'leather') then 'active'
            onClick: @handleCollectionClick
            value: 'leather',
            'Leather'
        p {},
          input
            type: 'checkbox',
            value: v.summerSale,
            ref: 'summerSale',
            onChange: @handleChange
          'Only show summer sale products.'
      div className: 'pricelist-header',
        ul className: 'pager',
          li className: 'previous disabled',
            a
              className: 'left'
              role: 'button'
              ref: 'pager-previous',
                '&#60;'
          li className: 'pageselect', 'dropdown'
          li className: 'pagecount', '1/ 10101010'
          li className: 'next',
            a
              className: 'right'
              role: 'button'
              ref: 'pager-next',
                '&#62;'

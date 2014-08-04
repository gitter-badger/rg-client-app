(function() {
  var React, td, tr, _ref;

  React = require('react');

  _ref = require('reactionary'), tr = _ref.tr, td = _ref.td;

  module.exports = React.createClass({
    render: function() {
      var item, tds;
      tds = [];
      item = this.props.item;
      if (this.props.filter.category !== 'passementerie') {
        if (this.props.showName) {
          tds.push(td({
            className: 'c-name'
          }, item.name));
        } else {
          tds.push(td({
            className: 'c-name'
          }, ''));
        }
      }
      tds.push(td({
        className: 'c-number'
      }, item.id));
      tds.push(td({
        className: 'c-color'
      }, item.color));
      tds.push(td({
        className: 'c-price'
      }, ''));
      tds.push(td({
        className: 'c-content'
      }, ''));
      if (this.props.filter.category !== 'leather') {
        tds.push(td({
          className: 'c-repeat'
        }, ''));
      }
      tds.push(td({
        className: 'c-size'
      }, ''));
      return tr({
        className: 'color'
      }, tds);
    }
  });

}).call(this);

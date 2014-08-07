(function() {
  var React, a, button, div, img, li, ul, _ref;

  React = require('react');

  _ref = require('reactionary'), div = _ref.div, button = _ref.button, ul = _ref.ul, li = _ref.li, a = _ref.a, img = _ref.img;

  module.exports = React.createClass({
    getInitialState: function() {
      return {
        pg: 0,
        pgSize: 5
      };
    },
    propTypes: {
      collection: React.PropTypes.object.isRequired
    },
    handleColorClick: function(e) {
      var color_id;
      color_id = e.target.value;
      if (e.preventDefault) {
        e.preventDefault();
      }
      console.log(color_id);
      return this.props.handleUserInput({
        color_id: color_id
      });
    },
    handleUnitClick: function(e) {
      var unit;
      unit = e.target.value;
      if (e.preventDefault) {
        e.preventDefault();
      }
      return this.setState({
        unit: unit
      });
    },
    handleXclick: function(e) {
      if (e.preventDefault) {
        e.preventDefault();
      }
      return this.props.setParentState({
        colorBoxView: false
      });
    },
    loadMetricRuler: function() {
      var item, ruler_img;
      if (!this.state.loadedMetric) {
        item = this.props.model;
        ruler_img = new Image();
        ruler_img.src = item.rulerPath.cm[this.props.imgSize];
        console.log('prefetch metric ruler ' + ruler_img.src);
        return this.setState({
          loadedMetric: true
        });
      }
    },
    render: function() {
      var closeButton, header, limit, offset, pageItems, pager_txt, pages, relatedColorItems, relatedColorsList;
      pages = Math.ceil(this.props.collection.length / 5);
      if (pages > 1) {
        pager_txt = (this.state.pg + 1) + ' / ' + pages;
      } else {
        pager_txt = '';
      }
      closeButton = button({
        key: 'close',
        className: 'close plain',
        onClick: this.handleXclick,
        type: 'button'
      }, 'X');
      header = div({
        className: 'colors-header'
      }, pager_txt, closeButton);
      offset = this.state.pg * this.state.pgSize;
      limit = (this.state.pg + 1) * this.state.pgSize;
      pageItems = this.props.collection.models.slice(offset, limit);
      relatedColorItems = [];
      pageItems.forEach(function(item) {
        return relatedColorItems.push(li({
          key: item.id,
          className: 'related-item'
        }, img({
          onClick: this.handleColorClick,
          type: 'button',
          value: item.color_id,
          src: item._file.small.path,
          alt: item.color
        })));
      });
      relatedColorsList = ul({
        className: 'list-inline list'
      });
      return div({
        id: 'related-colors',
        className: 'hidden-xs'
      }, header, relatedColorItems);
    }
  });

}).call(this);

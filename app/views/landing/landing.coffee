React = require 'react/addons'
ReactCSSTransitionGroup = React.addons.CSSTransitionGroup
{div, img, ul, ol, li, a, button} = require 'reactionary'
_ = require 'lodash'
Hammer = require 'hammerjs'

SlideItem = require './slide_item'
Indicators = require './indicators'

module.exports = React.createClass
  getInitialState: ->
    startingSlide = _.random 0, @data.length-1
    activeSlide: startingSlide
    prevSlide: 0
    showNotice: app.me.showNotice

  componentWillMount: ->
    app.items.clearFilters()

  componentDidUpdate: ->
    clearInterval @interval
    @interval = setInterval @next, 10000

  componentDidMount: ->
    reactElement = document.getElementById('react')
    @mc = new Hammer(reactElement)
    @mc.on 'swipeleft', @next
    @mc.on 'swiperight', @prev
    @interval = setInterval @next, 7000

  componentWillUnmount: ->
    clearInterval @interval
    @mc.off 'swipeleft', @next
    @mc.off 'swiperight', @prev

  prev: ->
    if @state.activeSlide == 0
      @setState
        activeSlide: @data.length-1
        prevSlide: @data.length
    else
      @setState
        activeSlide: @state.activeSlide-1
        prevSlide: @state.activeSlide

  next: ->
    if @state.activeSlide == @data.length-1
      @setState
        activeSlide: 0
        prevSlide: 0
    else
      @setState
        activeSlide: @state.activeSlide+1
        prevSlide: @state.activeSlide

  data: [
    ['910079-02', '92208-03', '92210-02', '93701-05', '806017-01']
    ['92931-01', '938027-04', '91024-14', '92209-11', '92902-04']
    ['92535-02', '870004-10', '92705-12', '800002-09', '92201-05']
    ['750002-21', '750005-14', '92509-24', '91024-12', '890003-08']
    ['92530-01', '92207-01', '92535-01', '938026-05', '92209-12']
    ['92401-14', '910097-07', '890013-04', '750004-04', '890014-05']
    ['890015-02', '910034-08', '92902-06', '890018-05', '92702-12']
    ['750002-15', '750004-07', '92535-05', '92702-15', '92209-07']
    ['750005-19', '750002-09', '910065-03', '890018-07', '938006-02']
  ]
  handleNoticeClose: ->
    @setState showNotice: false
    app.me.showNotice = false

  render: ->
    activeSlide = @state.activeSlide
    slideIds = @data[activeSlide]
    slideItems = slideIds.map (id, i) -> SlideItem
      key: id
      model: app.items.get(id)
      i: i
    slideImg = "http://r_g.cape.io/beautyshots/"+(activeSlide+1)+"_1500.jpg"
    if @state.activeSlide < @state.prevSlide
      transitionClass = 'carousel-right'
    else
      transitionClass = 'carousel-left'
    noticeBoxClassName = if @state.showNotice then 'sorry-world' else 'hidden'

    div
      id: 'landing',
        div id: 'fixit-wrap',
          div className: 'slide',
            a
              href: '#collection',
                ReactCSSTransitionGroup
                  transitionName: transitionClass,
                    img
                      src: slideImg
                      key: slideImg
            ul
              className: 'image-map',
                slideItems
          Indicators
            slides: @data
            activeSlide: activeSlide
            setLanderState: (newSt) => @setState newSt

          a
            role: 'button'
            onClick: @prev
            className: 'left control',
              'Previous'
          a
            role: 'button'
            onClick: @next
            className: 'right control',
              'Next'

        div {id: 'notice-box', className: noticeBoxClassName},
          a
            href: "#trade/login",
              img
                src: '/media/summer-sale-fabrics-banner-fall2015.jpg'
                alt: 'Summer Fabric Sale'
          button
            className: 'close'
            onClick: @handleNoticeClose,
              'Close'

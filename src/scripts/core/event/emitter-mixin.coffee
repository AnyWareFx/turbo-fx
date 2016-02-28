_ = require 'underscore'


module.exports =

  observe: (type, observer) ->
    if _.has(@observers, type) and _.isFunction observer
      alreadyListening = _.contains @observers[type], observer
      @observers[type].push observer if not alreadyListening
    @


  unobserve: (type, observer) ->
    if _.has(@observers, type) and _.isFunction observer
      index = _.indexOf @observers[type], observer
      found = index > -1
      @observers[type].splice index, 1 if found
    @


  emit: (event) ->
    if event?.type? and _.has @observers, event.type
      if event.type.toLowerCase().endsWith 'ing'
        return _.any @observers[event.type], (observe) ->
          observe event
      else
        _.each @observers[event.type], (observe) ->
          observe event

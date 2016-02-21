_ = require 'underscore'


Mixin =
  on: (type, listener) ->
    if _.has(@listeners, type) and _.isFunction listener
      alreadyListening = _.contains @listeners[type], listener
      @listeners[type].push listener if not alreadyListening
    @


  off: (type, listener) ->
    if _.has(@listeners, type) and _.isFunction listener
      index = _.indexOf @listeners[type], listener
      found = index > -1
      @listeners[type].splice index, 1 if found
    @


# TODO Mixin into Emitter

class Emitter
  constructor: ->


  on: (type, listener) ->
    if _.has(@listeners, type) and _.isFunction listener
      alreadyListening = _.contains @listeners[type], listener
      @listeners[type].push listener if not alreadyListening
    @


  off: (type, listener) ->
    if _.has(@listeners, type) and _.isFunction listener
      index = _.indexOf @listeners[type], listener
      found = index > -1
      @listeners[type].splice index, 1 if found
    @


module.exports = Emitter

_ = require 'underscore'


class Model

  constructor: (@properties = {}) ->
    @listeners =
      changing: []
      changed:  []


  addListener: (type, listener) ->
    if _.has(@listeners, type) and _.isFunction listener
      alreadyListening = _.contains @listeners[type], listener
      @listeners[type].push listener if not alreadyListening


  removeListener: (type, listener) ->
    if _.has(@listeners, type) and _.isFunction listener
      index = _.indexOf @listeners[type], listener
      found = index > -1
      @listeners[type].splice index, 1 if found


  get: (name) ->
    @properties[name]


  set: (name, value) ->
    if arguments.length == 1
      object = name

      properties = _.omit object, _.functions object
      names = _.keys properties

      _.each names, (name) =>
        @set name, properties[name]

    else if _.isString(name) and value != @properties[name]
      oldValue = @properties[name]

      cancelled = _.any @listeners.changing, (listener) ->
        listener
          type: 'changing'
          name: name
          oldValue: oldValue
          newValue: value

      unless cancelled
        @properties[name] = value

        _.each @listeners.changed, (listener) ->
          listener
            type: 'changed'
            name: name
            oldValue: oldValue
            newValue: value


  toJSON: ->
    _.clone @properties


  fromJSON: (json) ->
    @properties = JSON.parse json


module.exports = Model
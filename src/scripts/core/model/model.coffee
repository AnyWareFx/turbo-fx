_ = require 'underscore'


class Model

  constructor: (@attributes = {}) ->
    @listeners = []


  addListener: (listener) ->
    listening = _.contains @listeners, listener
    if !listening and _.isFunction listener
      @listeners.push listener


  removeListener: (listener) ->
    index = _.indexOf @listeners, listener
    @listeners.splice index, 1 if index != -1


  get: (name) ->
    @attributes[name]


  set: (name, value) ->
    if value != @attributes[name]
      oldValue = @attributes[name]
      @attributes[name] = value

      _.each @listeners, (listener) ->
        listener
          type: 'change'
          name: name
          oldValue: oldValue
          newValue: value


  toJSON: ->
    _.clone @attributes


  fromJSON: (json) ->
    @attributes = JSON.parse json


module.exports = Model
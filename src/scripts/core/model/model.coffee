_ = require 'underscore'


class Model

  constructor: (@properties = {}) ->
    @listeners = []


  addListener: (listener) ->
    listening = _.contains @listeners, listener
    if !listening and _.isFunction listener
      @listeners.push listener


  removeListener: (listener) ->
    index = _.indexOf @listeners, listener
    @listeners.splice index, 1 if index != -1


  get: (name) ->
    @properties[name]


  set: (name, value) ->
    if _.isString name
      if value != @properties[name]
        oldValue = @properties[name]
        @properties[name] = value

        _.each @listeners, (listener) ->
          listener
            type: 'change'
            name: name
            oldValue: oldValue
            newValue: value

    else if arguments.length == 1
      object = name

      properties = _.omit object, _.functions object
      names = _.keys properties

      _.each names, (name) =>
        @set name, properties[name]



  toJSON: ->
    _.clone @properties


  fromJSON: (json) ->
    @properties = JSON.parse json


module.exports = Model
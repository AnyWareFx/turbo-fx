_            = require 'underscore'
EventEmitter = require '../event/emitter'


class Model extends EventEmitter
  @Events:
    CHANGING: 'changing'
    CHANGED:  'changed'


  constructor: (@properties = {}) ->
    super()
    @listeners =
      changing: []
      changed:  []


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
          type: Model.Events.CHANGING
          name: name
          oldValue: oldValue
          newValue: value

      unless cancelled
        @properties[name] = value

        _.each @listeners.changed, (listener) ->
          listener
            type: Model.Events.CHANGED
            name: name
            oldValue: oldValue
            newValue: value


  clone: ->
    new @constructor _.clone @properties


  copyFrom: (other) ->
    @properties = _.clone other.properties


  toJSON: ->
    JSON.stringify _.clone @properties


  fromJSON: (json) ->
    @properties = JSON.parse json


module.exports = Model
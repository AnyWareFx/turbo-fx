_            = require 'underscore'
EventEmitter = require '../event/emitter'


_.mixin
  isScalar: (param) ->
    _.isNumber(param)  or
    _.isString(param)  or
    _.isDate(param)    or
    _.isBoolean(param)



class Model extends EventEmitter
  @Events:
    CHANGING: 'changing'
    CHANGED:  'changed'


  constructor: (properties = {}) ->
    super()
    @properties = {}
    @set properties = _.defaults {}, properties, { locked: false, frozen: false }
    @observers =
      changing: []
      changed:  []


  _nameAllowed: (name) ->
    _.isString(name) and
    (
      not @properties.locked or
      @has name
    )

  _valueAllowed: (name, value) ->
    (
      name in ['frozen', 'locked'] and
      _.isBoolean(value)
    ) or
    (
      not @properties.frozen and
      _.isScalar(value) and
      value != @properties[name]
    )

  get: (name) ->
    @properties[name]


  set: (name, value) ->
    if arguments.length == 1
      object = name

      properties = _.omit object, _.functions object
      names = _.keys properties

      _.each names, (name) =>
        @set name, properties[name]

    else if @_nameAllowed(name) and @_valueAllowed(name, value)
      oldValue = @properties[name]

      cancelled = @emit
        type: Model.Events.CHANGING
        name: name
        oldValue: oldValue
        newValue: value

      unless cancelled
        @properties[name] = value

        @emit
          type: Model.Events.CHANGED
          name: name
          oldValue: oldValue
          newValue: value
    @


  has: (key) ->
    _.has @properties, key


  keys: ->
    _.keys @properties


  values: ->
    _.values @properties


  pick: (keys) ->
    _.pick @properties, keys


  omit: (keys) ->
    _.omit @properties, keys


  clone: ->
    new @constructor _.clone @properties


  copyFrom: (other) ->
    @set _.clone other.properties if other?.properties?
    @


  toJSON: ->
    JSON.stringify _.clone @properties


  fromJSON: (json) ->
    @set JSON.parse json if _.isString json
    @


module.exports = Model

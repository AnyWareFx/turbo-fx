_         = require 'underscore'
Schema    = require './schema'
{ Model } = require '../model'



class DataModel extends Model
  constructor: (properties = {}) ->
    @validationErrors = {}
    @schema = null
    super


  _valueAllowed: (name, value) ->
    (
      name is 'schema' and
        value instanceof Schema

    ) or super


#  get: (name) ->



  set: (name, value) ->
    if arguments.length == 1
      super

    else if @_nameAllowed(name) and @_valueAllowed(name, value)
      if name is 'schema' and not @schema?
        @properties = {}
        @schema = value

        @schema.propertyModels.each (property) =>
          @properties[property.get 'name'] = property.get 'defaultValue'

        @set 'locked', @schema.get 'strict'

      else if name is 'locked'
        @properties.locked = @schema?.get('strict') or value
    @


  validate: ->
    @validationErrors = @schema.validate @properties
    @validationErrors


  isValid: ->
    @validate()
    _.isEmpty @validationErrors



module.exports = DataModel

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


  set: (name, value) ->
    if name is 'schema'
      unless @schema?
        if value instanceof Schema
          @properties = {}
          @schema = value

          @schema.propertyModels.each (property) =>
            @properties[property.get 'name'] = property.get 'defaultValue'

          @set 'locked', @schema.get 'strict'
      @

    else if name is 'locked'
      if @schema? and _.isBoolean value
        @properties.locked = @schema.get('strict') or value
      @

    else
      super


  validate: ->
    @validationErrors = @schema.validate @properties
    @validationErrors


  isValid: ->
    @validate()
    _.isEmpty @validationErrors



module.exports = DataModel

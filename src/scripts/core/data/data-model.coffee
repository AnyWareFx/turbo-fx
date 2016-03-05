_         = require 'underscore'
{ Model } = require '../model'


class DataModel extends Model
  constructor: () ->
    super()
    @validationErrors = {}
    @schema = null


  initialize: (schema) ->
    unless @schema
      @properties = {}
      @schema = schema

      @schema.propertyModels.each (property) =>
        @properties[property.get 'name'] = property.get 'defaultValue'

      @set 'locked', @schema.get 'strict'


  validate: ->
    @validationErrors = @schema.validate @properties
    @validationErrors


  isValid: ->
    @validate()
    _.isEmpty @validationErrors



module.exports = DataModel

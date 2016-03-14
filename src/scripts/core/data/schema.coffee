_                     = require 'underscore'
{ Model, Collection } = require '../model'
PropertyModel         = require './property-model'


class Schema extends Model
  constructor: (properties = {}) ->
    super _.defaults {}, properties, strict: true
    @propertyModels = new Collection ModelClass: PropertyModel


  _valueAllowed: (name, value) ->
    (
      name is 'propertyModels' and
        value instanceof Collection and
        value.ModelClass is PropertyModel

    ) or super


  set: (name, value) ->
    if name is 'propertyModels' and value instanceof Collection and value.ModelClass is PropertyModel
      value.each (propertyModel) =>
        @propertyModels.add propertyModel
      @

    else
      super


  property: (attributes) ->
    @propertyModels.add new PropertyModel attributes
    @


  validate: (properties = {}) ->
    validationErrors = {}

    _.each _.keys(properties), (name) =>
      model = @propertyModels.findWhere name: name
      if model?
        message = model.validate properties[name]
        validationErrors[name] = message if not _.isEmpty message

    validationErrors



module.exports = Schema

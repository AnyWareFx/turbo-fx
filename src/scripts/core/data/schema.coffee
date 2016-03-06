_                     = require 'underscore'
{ Model, Collection } = require '../model'
PropertyModel         = require './property-model'


class Schema extends Model
  constructor: (properties = {}) ->
    super properties

    { @propertyModels } = _.defaults {}, properties,
      strict: true
      propertyModels: new Collection ModelClass: PropertyModel


  validate: (properties = {}) ->
    validationErrors = {}

    _.each _.keys(properties), (name) =>
      model = @propertyModels.findWhere name: name
      if model?
        message = model.validate properties[name]
        validationErrors[name] = message

    validationErrors



module.exports = Schema

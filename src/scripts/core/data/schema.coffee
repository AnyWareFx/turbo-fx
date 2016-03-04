_                     = require 'underscore'
{ Model, Collection } = require '../model'
PropertyModel         = require './property-model'


class Schema extends Model
  constructor: (properties = {}) ->
    super properties

    @propertyModels = _.defaults properties,
      propertyModels: new Collection ModelClass: PropertyModel


module.exports = Schema

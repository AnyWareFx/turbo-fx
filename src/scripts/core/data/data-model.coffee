_ = require 'underscore'
{Model, Collection} = require '../model'


defaults =
  name: '',
  kind: '',
  required: false,
  defaultValue: null


class PropertyModel extends Model
  constructor: (attributes = {})->
    super _.defaults attributes, defaults
    @validators = []

  set: (name, value) ->
    if arguments.length == 1
      super()
    else if _.contains defaults, name
      super name, value


class Schema extends Model
  constructor: (attributes = {}) ->
    super attributes

    {@validators, @propertyModels} = _.defaults attributes,
      validators: [],
      propertyModels: new Collection()



class DataModel extends Model
  constructor: (attributes = {}) ->
    super attributes

    @schema = _.defaults attributes,
      schema: new Schema()


module.exports = DataModel

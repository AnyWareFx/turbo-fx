_          = require 'underscore'

DataTypes  = require './data-types'
Validators = require './validators'
{ Model }  = require '../model'


defaults =
  name: ''
  dataType: ''
  defaultValue: null
  required: false
  indexed: false



class PropertyModel extends Model
  constructor: (attributes = {})->
    allowed = _.pick attributes, _.keys defaults
    super _.defaults allowed, defaults
    @set locked: true


  _valueAllowed: (name, value) ->
    (
      name in ['required', 'indexed'] and
        _.isBoolean value

    ) or (
      name is 'dataType' and
        value in _.values DataTypes

    ) or super


  validate: (value) ->
    message = ''
    validator = Validators[@get 'dataType']

    if value? and not validator?.validate(value)
      message = validator.errorMessage

    message



module.exports = PropertyModel

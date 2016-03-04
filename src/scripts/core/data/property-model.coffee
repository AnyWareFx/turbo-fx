_          = require 'underscore'
validators = require 'validator'

DataTypes  = require './data-types'
{ Model }  = require '../model'


defaults =
  name: ''
  dataType: ''
  required: false
  errorMessage: ''
  defaultValue: null


class PropertyModel extends Model
  constructor: (attributes = {})->
    allowed = _.pick attributes, _.keys defaults
    super _.defaults allowed, defaults
    @set locked: true


  _valueAllowed: (name, value) ->
    (
      name is 'required' and
        _.isBoolean value

    ) or (
      name is 'dataType' and
        value in _.keys DataTypes

    ) or super name, value


  validate: (value) ->
    DataType = DataTypes[@get 'dataType']

    if DataType? and validators[DataType.validator]?
      if validators[DataType.validator](value)
        message = ''
      else
        message = DataType.errorMessage
    else
      message = 'invalid data type'

    @set 'errorMessage', message
    @get 'errorMessage'


module.exports = PropertyModel

_         = require 'underscore'
validator = require 'validator'
moment    = require 'moment'

DataTypes = require './data-types'
{ Model } = require '../model'


validators = _.extend {},
  validator,
  isDate: (date) ->
    moment(date).isValid()


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

    if validators[DataType.validator](value)
      message = ''
    else
      message = DataType.errorMessage

    @set 'errorMessage', message
    @get 'errorMessage'


module.exports = PropertyModel

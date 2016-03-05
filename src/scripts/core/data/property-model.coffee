_         = require 'underscore'
validator = require 'validator'
moment    = require 'moment'

DataTypes = require './data-types'
{ Model } = require '../model'



validators = _.extend {},
  validator,
  isDate: (date) ->
    moment(date, 'MM/DD/YYYY').isValid() # FIXME


defaults =
  name: ''
  dataType: ''
  required: false
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
    message = ''
    DataType = DataTypes[@get 'dataType']

    if value? and not validators[DataType.validator](value)
      message = DataType.errorMessage

    message



module.exports = PropertyModel

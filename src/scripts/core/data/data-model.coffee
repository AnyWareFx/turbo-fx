_                     = require 'underscore'
validator             = require 'validator'
{ Model, Collection } = require '../model'


defaults =
  name: '',
  kind: '',
  required: false,
  defaultValue: null


class PropertyModel extends Model
  @Kinds:
    ALPHA:          'isAlpha'
    ALPHA_NUMERIC:  'isAlphanumeric'
    ASCII:          'isAscii'
    BASE64:         'isBase64'
    BOOLEAN:        'isBoolean'
    CREDIT_CARD:    'isCreditCard'
    CURRENCY:       'isCurrency'
    DATE:           'isDate'
    DECIMAL:        'isDecimal'
    EMAIL:          'isEmail'
    FQDN:           'isFQDN'
    FLOAT:          'isFloat'
    HEX_COLOR:      'isHexColor'
    HEXADECIMAL:    'isHexadecimal'
    IP:             'isIP'
    ISBN:           'isISBN'
    ISIN:           'isISIN'
    ISO8601:        'isISO8601'
    INT:            'isInt'
    JSON:           'isJSON'
    MOBILE_PHONE:   'isMobilePhone'
    NUMERIC:        'isNumeric'
    URL:            'isURL'
    UUID:           'isUUID'


  constructor: (attributes = {})->
    allowed = _.pick attributes, _.keys defaults
    super _.defaults allowed, defaults
    @set locked: true
    @validators = []


  _valueAllowed: (name, value) ->
    (
      name is 'required' and
      _.isBoolean value

    ) or (
      name is 'kind' and
      value in _.keys PropertyModel.Kinds

    ) or super name, value



class Schema extends Model
  constructor: (attributes = {}) ->
    super attributes

    {@validators, @propertyModels} = _.defaults attributes,
      validators: [],
      propertyModels: new Collection()



class DataModel extends Model


module.exports = { DataModel, Schema, PropertyModel }

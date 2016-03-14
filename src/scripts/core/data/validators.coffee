_         = require 'underscore'

validator = require 'validator'


validators = _.extend {}, validator,
  isDate: (date) ->
    not isNaN Date.parse date


# TODO i18n.t '...'
Validators =
  ALPHA:
    validate:      validators.isAlpha
    errorMessage: 'requires letters only'

  ALPHA_NUMERIC:
    validate:      validators.isAlphanumeric
    errorMessage: 'requires letters and numbers only'

  ASCII:
    validate:      validators.isAscii
    errorMessage: 'requires ASCII characters only'

  BASE64:
    validate:      validators.isBase64
    errorMessage: 'requires Base64 encoding'

  BOOLEAN:
    validate:      validators.isBoolean
    errorMessage: 'requires true/false only'

  CREDIT_CARD:
    validate:      validators.isCreditCard
    errorMessage: 'invalid credit card number'

  CURRENCY:
    validate:      validators.isCurrency
    errorMessage: 'invalid currency value'

  DATE:
    validate:      validators.isDate
    errorMessage: 'invalid date'

  DECIMAL:
    validate:      validators.isDecimal
    errorMessage: 'requires decimal numbers only'

  EMAIL:
    validate:      validators.isEmail
    errorMessage: 'invalid email address'

  FQDN:
    validate:      validators.isFQDN
    errorMessage: 'invalid fully qualified domain name'

  FLOAT:
    validate:      validators.isFloat
    errorMessage: 'requires floating point numbers only'

  HEX_COLOR:
    validate:      validators.isHexColor
    errorMessage: 'invalid hexadecimal color value'

  HEXADECIMAL:
    validate:      validators.isHexadecimal
    errorMessage: 'requires hexadecimal values only'

  IP:
    validate:      validators.isIP
    errorMessage: 'invalid IP address'

  ISBN:
    validate:      validators.isISBN
    errorMessage: 'invalid ISBN number'

  ISIN:
    validate:      validators.isISIN
    errorMessage: 'invalid ISIN number'

  ISO8601:
    validate:      validators.isISO8601
    errorMessage: 'invalid ISO 8601 date value'

  INT:
    validate:      validators.isInt
    errorMessage: 'requires integer values only'

  JSON:
    validate:      validators.isJSON
    errorMessage: 'invalid JSON format'

  MOBILE_PHONE:
    validate:      validators.isMobilePhone
    errorMessage: 'invalid mobile phone number format'

  NUMERIC:
    validate:      validators.isNumeric
    errorMessage: 'requires numbers only'

  STRING:
    validate:      validators.isLength    # FIXME temporary validator
    errorMessage: 'invalid string'

  URL:
    validate:      validators.isURL
    errorMessage: 'invalid URL format'

  UUID:
    validate:      validators.isUUID
    errorMessage: 'requires UUID values only'


module.exports = Validators

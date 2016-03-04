# TODO i18n.t '...'
DataTypes =
  ALPHA:
    validator:    'isAlpha'
    errorMessage: 'requires letters only'

  ALPHA_NUMERIC:
    validator:    'isAlphanumeric'
    errorMessage: 'requires letters and numbers only'

  ASCII:
    validator:    'isAscii'
    errorMessage: 'requires ASCII characters only'

  BASE64:
    validator:    'isBase64'
    errorMessage: 'requires Base64 encoding'

  BOOLEAN:
    validator:    'isBoolean'
    errorMessage: 'requires true/false only'

  CREDIT_CARD:
    validator:    'isCreditCard'
    errorMessage: 'invalid credit card number'

  CURRENCY:
    validator:    'isCurrency'
    errorMessage: 'invalid currency value'

  DATE:
    validator:    'isDate'
    errorMessage: 'invalid date'

  DECIMAL:
    validator:    'isDecimal'
    errorMessage: 'requires decimal numbers only'

  EMAIL:
    validator:    'isEmail'
    errorMessage: 'invalid email address'

  FQDN:
    validator:    'isFQDN'
    errorMessage: 'invalid fully qualified domain name'

  FLOAT:
    validator:    'isFloat'
    errorMessage: 'requires floating point numbers only'

  HEX_COLOR:
    validator:    'isHexColor'
    errorMessage: 'invalid hexadecimal color value'

  HEXADECIMAL:
    validator:    'isHexadecimal'
    errorMessage: 'requires hexadecimal values only'

  IP:
    validator:    'isIP'
    errorMessage: 'invalid IP address'

  ISBN:
    validator:    'isISBN'
    errorMessage: 'invalid ISBN number'

  ISIN:
    validator:    'isISIN'
    errorMessage: 'invalid ISIN number'

  ISO8601:
    validator:    'isISO8601'
    errorMessage: 'invalid ISO 8601 date value'

  INT:
    validator:    'isInt'
    errorMessage: 'requires integer values only'

  JSON:
    validator:    'isJSON'
    errorMessage: 'invalid JSON format'

  MOBILE_PHONE:
    validator:    'isMobilePhone'
    errorMessage: 'invalid mobile phone number format'

  NUMERIC:
    validator:    'isNumeric'
    errorMessage: 'requires numbers only'

  URL:
    validator:    'isURL'
    errorMessage: 'invalid URL format'

  UUID:
    validator:    'isUUID'
    errorMessage: 'requires UUID values only'


module.exports = DataTypes

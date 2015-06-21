_ = require '../../node_modules/underscore/underscore'


standard =
  enumerable: true
  configurable: false
  get: ->
    @value
  set: (value) ->
    @value = value


Function::property = (name, attributes) ->
  # Determine what given attributes are standard and extended
  extended = _.difference attributes, standard
  explicit = _.difference attributes, extended

  # Default the descriptor attributes
  descriptor = _.defaults explicit, standard

  # If the extended metadata includes 'injected', make the property write-once
  descriptor.set = (value) -> @value ?= value if _.has extended, 'injected'

  # Save the metadata of this property for introspection
  @metadata.push name: name, descriptor: descriptor, extended: extended unless name is 'metadata'

  # Define the property on the prototype of the class in which it's declared
  Object.defineProperty @prototype, name, descriptor

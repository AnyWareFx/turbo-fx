{ Model } = require '../../src/scripts/core/model'


class Person extends Model


class Employee extends Person


class Address
  constructor: (properties) ->
    { @address1, @address2, @city, @state, @zip } = properties


class ContactPoint
  constructor: (properties) ->
    { @type, @address, @phone, @email } = properties


module.exports = { Person, Employee, Address, ContactPoint }

{ Model }     = require '../../src/scripts/core/model'
{ DataModel } = require '../../src/scripts/core/data'


class Person extends Model


class Employee extends Person


class Address
  constructor: (properties) ->
    { @address1, @address2, @city, @state, @zip } = properties


class ContactPoint extends DataModel


module.exports = { Person, Employee, Address, ContactPoint }

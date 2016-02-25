Model = require '../../src/scripts/core/model/model'


class Person extends Model


class Employee extends Person


class Address
  constructor: ->
    @address1
    @address2
    @city
    @state
    @zip


class ContactPoint
  constructor: ->
    @type
    @address
    @phone
    @email


module.exports = ->
  Person: Person
  Address: Address
  ContactPoint: ContactPoint
  Employee: Employee

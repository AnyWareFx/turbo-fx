Model = require '../../src/scripts/core/model/model'


class Person extends Model
  @firstName
  @lastName
  @contactPoints = []


class Address
  @address1
  @address2
  @city
  @state
  @zip


class ContactPoint
  @type
  @address
  @phone
  @email


class Employee extends Person
  @startDate
  @endDate


module.exports = ->
  Person: Person
  Address: Address
  ContactPoint: ContactPoint
  Employee: Employee

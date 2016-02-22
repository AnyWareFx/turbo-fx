_ = require 'underscore'

logEvent = (event) ->
  console.log event

cancelLastName = (event) ->
  console.log event
  event.name == 'lastName'


########################

Model      = require './src/scripts/core/model/model'
Collection = require './src/scripts/core/model/collection'

Dave = new Model firstName: 'Dave', lastName: 'Jackson'
Rosemary = new Model firstName: 'Rosemary', lastName: 'Jackson'

people = new Collection
people.observe 'added', logEvent
people.observe 'removed', logEvent
people.observe 'changed', logEvent
people.add Dave
people.add Rosemary

#Dave.observe 'changed', logEvent
Dave.set 'firstName', 'David'


#Dave.unobserve 'changed', logEvent
#Dave.set 'firstName', 'Dave'


#Dave.observe 'changed', logEvent
#Dave.observe 'changing', cancelLastName
Dave.set firstName: 'David', lastName: 'Jackson II', func: ->


########################

fs      = require 'fs'
models  = require './features/support/factory-models'
Factory = require './src/scripts/core/factory/factory'

fixture = JSON.parse fs.readFileSync 'features/fixtures/factory-fixture.json', 'utf8'

Factory.initialize models(), fixture


home = Factory.get 'HomeAddress'
console.log home.address1

dave = Factory.get 'Dave'
console.log dave.get 'firstName'
console.log _.findWhere dave.get 'contactPoints', { type: 'home' }
console.log _.findWhere dave.get 'contactPoints', { type: 'work' }

employee = Factory.get 'EmployeeDave'
console.log employee.get 'startDate'

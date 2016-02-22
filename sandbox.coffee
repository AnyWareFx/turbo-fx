_ = require 'underscore'

logEvent = (event) ->
  console.log event

cancelLastName = (event) ->
  console.log event
  event.name == 'lastName'


########################

Model   = require './src/scripts/core/model/model'

dave = new Model firstName: 'Dave', lastName: 'Jackson'


dave.observe 'changed', logEvent
dave.set 'firstName', 'David'


dave.unobserve 'changed', logEvent
dave.set 'firstName', 'Dave'


dave.observe 'changed', logEvent
dave.observe 'changing', cancelLastName
dave.set firstName: 'David', lastName: 'Jackson II', func: ->


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

employeeDave = Factory.get 'EmployeeDave'
console.log employeeDave.get 'startDate'

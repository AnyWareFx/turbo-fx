_       = require 'underscore'
fs      = require 'fs'

models  = require './features/support/factory-models'
Factory = require './src/scripts/core/factory/factory'
Model   = require './src/scripts/core/model/model'


listener = (event) ->
  console.log event

dave = new Model { firstName: 'Dave', lastName: 'Jackson' }
dave.addListener listener
dave.set 'firstName', 'David'
dave.removeListener listener
dave.set 'firstName', 'Dave'


fixture = JSON.parse fs.readFileSync 'features/fixtures/factory-fixture.json', 'utf8'


Factory.initialize models(), fixture


home = Factory.get 'HomeAddress'
address1 = home.address1

dave = Factory.get 'Dave'
firstName = dave.firstName
home = _.findWhere dave.contactPoints, { type: 'home' }
work = _.findWhere dave.contactPoints, { type: 'work' }

employeeDave = Factory.get 'EmployeeDave'
startDate = employeeDave.startDate

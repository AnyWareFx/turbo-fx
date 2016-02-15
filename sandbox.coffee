_       = require 'underscore'
fs      = require 'fs'

models  = require('./features/support/factory-models')()
factory = require('./src/scripts/core/factory/factory').getInstance()

fixture = JSON.parse fs.readFileSync 'features/fixtures/factory-fixture.json', 'utf8'

factory.initialize models, fixture

home = factory.getComponent 'HomeAddress'
address1 = home.address1

dave = factory.getComponent 'Dave'
firstName = dave.firstName
home = _.findWhere dave.contactPoints, { type: 'home' }
work = _.findWhere dave.contactPoints, { type: 'work' }

employeeDave = factory.getComponent 'EmployeeDave'
startDate = employeeDave.startDate

employeeDave2 = factory.getComponent 'EmployeeDave'
startDate = employeeDave2.startDate

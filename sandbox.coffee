_ = require 'underscore'


logEvent = (event) ->
  console.log event
  console.log '\n'


########################

Model       = require './src/scripts/core/model/model'
Collection  = require './src/scripts/core/model/collection'
Context     = require './src/scripts/core/command/command-context'
SetProperty = require './src/scripts/core/command/set-property-command'

context = new Context

Dave = new Model firstName: 'Dave', lastName: 'Jackson'
Rosemary = new Model firstName: 'Rosemary', lastName: 'Jackson'
Mariah = new Model firstName: 'Mariah', lastName: 'Seifert'
Manitou = new Model firstName: 'Manitou'

console.log 'Model pick'
console.log Dave.pick 'firstName'
console.log '\n'

people = new Collection
people.observe 'added', logEvent
people.observe 'removed', logEvent
people.observe 'changed', logEvent
people.add Dave
people.add Rosemary
people.add Mariah
people.add Manitou

console.log 'Collection pluck'
console.log people.pluck 'firstName'
console.log '\n'

console.log 'Collection find'
console.log people.find (person) -> 'Jackson' == person.get 'lastName'
console.log '\n'

console.log 'Collection where lastName: ' + 'Jackson'
console.log people.where lastName: 'Jackson'
console.log '\n'

console.log 'Collection where first+last'
console.log people.where firstName: 'Rosemary', lastName: 'Jackson'
console.log '\n'

console.log 'Collection findWhere'
console.log people.findWhere lastName: 'Jackson'
console.log '\n'

command = new SetProperty target: Dave, property: 'firstName', value: 'David'
context.execute command

#Dave.observe 'changed', logEvent
#Dave.set 'firstName', 'David'
#Dave.unobserve 'changed', logEvent
#Dave.set 'firstName', 'Dave'
#Dave.observe 'changed', logEvent
#Dave.observe 'changing', cancelLastName

people.remove Dave

Dave.set firstName: 'David', lastName: 'Jackson II', func: ->
context.undo()


########################

fs      = require 'fs'
models  = require './features/support/factory-models'
Factory = require './src/scripts/core/factory/factory'

fixture = JSON.parse fs.readFileSync 'features/fixtures/factory-fixture.json', 'utf8'

Factory.initialize models(), fixture


home = Factory.get 'HomeAddress'
console.log home.address1
console.log '\n'

dave = Factory.get 'Dave'
console.log dave.get 'firstName'
console.log '\n'
console.log _.findWhere dave.get 'contactPoints', { type: 'home' }
console.log '\n'
console.log _.findWhere dave.get 'contactPoints', { type: 'work' }
console.log '\n'

employee = Factory.get 'EmployeeDave'
console.log employee.get 'startDate'

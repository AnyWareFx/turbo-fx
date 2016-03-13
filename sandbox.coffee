_  = require 'underscore'
fs = require 'fs'


{ CommandContext, SetPropertyCommand } = require './src/scripts/core/command'
{ DataModel, Schema }                  = require './src/scripts/core/data'
{ Factory }                            = require './src/scripts/core/factory'
{ Model, Collection }                  = require './src/scripts/core/model'


enableCommand = false
enableData    = true
enableFactory = false
enableModel   = true


logEvent = (event) ->
  console.log event
  console.log '\n'


Dave = new Model firstName: 'Dave', lastName: 'Jackson'


########################

if enableCommand
  Dave.observe 'changed', logEvent
  context = new CommandContext

  console.log 'SetPropertyCommand'
  command = new SetPropertyCommand target: Dave, property: 'firstName', value: 'David'
  context.execute command

  console.log 'Context.undo()'
  context.undo()
  console.log '\n'



########################

if enableData
  PersonSchema = new Schema name: 'Person', strict: false
    .property name: 'prefix',     dataType: 'STRING'
    .property name: 'firstName',  dataType: 'STRING'
    .property name: 'middleName', dataType: 'STRING'
    .property name: 'lastName',   dataType: 'STRING'
    .property name: 'suffix',     dataType: 'STRING'

  console.log PersonSchema


  person = new DataModel schema: PersonSchema, firstName: 'Dave', lastName: 'Jackson', locked: true
  person.set fullName: 'Dave Jackson'

  console.log person


  ContactSchema = new Schema name: 'Contact'
    .property name: 'email', dataType: 'EMAIL'
    .property name: 'date',  dataType: 'DATE'

  contact = new DataModel
    schema: ContactSchema
    email: 'dave.jackson'
    date:  '7/32/15'

  console.log contact.isValid()




########################

if enableFactory
  models  = require './features/support/example-models'

  fixture = JSON.parse fs.readFileSync 'features/fixtures/factory-fixture.json', 'utf8'

  Factory.initialize classes: models, templates: fixture


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



########################

if enableModel
  console.log 'Model pick'
  console.log Dave.pick 'firstName'
  console.log '\n'

  people = new Collection
  people.observe 'added', logEvent
  people.observe 'removed', logEvent
  people.observe 'changed', logEvent

  people.add [{
    firstName: 'Rosemary'
    lastName: 'Jackson'

  }, {
    firstName: 'Mariah'
    lastName: 'Seifert'

  }, {
    firstName: 'Manitou'
  }]

  people.add Dave

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

  Dave.set 'firstName', 'David'

  people.remove Dave

_  = require 'underscore'
fs = require 'fs'


{ CommandContext, SetPropertyCommand } = require './src/scripts/core/command'
{ DataModel, DataTypes, Schema }       = require './src/scripts/core/data'
{ Factory }                            = require './src/scripts/core/factory'
{ Model, Collection }                  = require './src/scripts/core/model'


enableCommand = false
enableData    = true
enableFactory = false
enableModel   = false


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
  schema = new Schema name: 'Person', strict: false
    .property name: 'prefix',     dataType: DataTypes.STRING
    .property name: 'firstName',  dataType: DataTypes.STRING
    .property name: 'middleName', dataType: DataTypes.STRING
    .property name: 'lastName',   dataType: DataTypes.STRING
    .property name: 'suffix',     dataType: DataTypes.STRING

  console.log schema


  model = new DataModel schema: schema
  model.set locked: true
  model.set firstName: 'Dave', lastName:  'Jackson'

  console.log model



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

  #Dave.observe 'changed', logEvent
  #Dave.set 'firstName', 'David'
  #Dave.unobserve 'changed', logEvent
  #Dave.set 'firstName', 'Dave'
  #Dave.observe 'changed', logEvent
  #Dave.observe 'changing', cancelLastName

  people.remove Dave

_  = require 'underscore'
fs = require 'fs'


{ CommandContext, SetPropertyCommand          } = require './src/scripts/core/command'
{ DataModel, Schema, PropertyModel, DataTypes } = require './src/scripts/core/data'
{ Factory                                     } = require './src/scripts/core/factory'
{ Model, Collection                           } = require './src/scripts/core/model'


enableCommand = false
enableData    = false
enableFactory = true
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
  PersonSchema = new Schema name: 'Person', strict: false
    .property name: 'prefix',     dataType: DataTypes.STRING
    .property name: 'firstName',  dataType: DataTypes.STRING
    .property name: 'middleName', dataType: DataTypes.STRING
    .property name: 'lastName',   dataType: DataTypes.STRING
    .property name: 'suffix',     dataType: DataTypes.STRING

  console.log PersonSchema


  person = new DataModel schema: PersonSchema, firstName: 'Dave', lastName: 'Jackson', locked: true
  person.set fullName: 'Dave Jackson'

  console.log person


  ContactSchema = new Schema name: 'Contact'
    .property name: 'email', dataType: DataTypes.EMAIL
    .property name: 'date',  dataType: DataTypes.DATE


#  ContactSchema = new Schema name: 'Contact'
#  propertyModels = new Collection ModelClass: PropertyModel
#  propertyModels.add new PropertyModel name: 'email', dataType: DataTypes.EMAIL
#  propertyModels.add new PropertyModel name: 'date',  dataType: DataTypes.DATE

#  ContactSchema.set propertyModels: propertyModels


  contact = new DataModel
    schema: ContactSchema
    email: 'dave.jackson'
    date:  '7/32/15'

  console.log contact.isValid()




########################

if enableFactory

  fixture = JSON.parse fs.readFileSync 'features/fixtures/factory-fixture.json', 'utf8'
  models = { Schema, PropertyModel, DataModel, Collection }

  Factory.initialize classes: models, templates: fixture

  schema = Factory.get 'PersonSchema'
  console.log schema

  person = Factory.get 'Dave'
  console.log person


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

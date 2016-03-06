{ expect } = require 'chai'
{ Person } = require '../../../support/example-models'

{ CommandContext, SetPropertyCommand } = require '../../../../src/scripts/core/command'


module.exports = ->

  @Given 'I have a Person (model)', () ->
    @model = new Person firstName: 'David', lastName: 'Jackson'
    @model


  @When 'I execute a command to set the "$property" property to "$value"', (property, value) ->
    @context = new CommandContext()
    @context.execute new SetPropertyCommand target: @model, property: property, value: value


  @When 'I undo the command', ->
    @context.undo()


  @When 'I redo the command', ->
    @context.redo()


  @Then 'the "$property" property value will equal "$value"', (property, value) ->
    expect(@model.get(property)).to.equal value

{ expect } = require 'chai'
{ Model  } = require '../../../src/scripts/core/model'


module.exports = ->

  @Given 'I have a Model', () ->
    @model = new Model firstName: 'David', lastName: 'Jackson'
    @model


  @When 'I add a "$property" property', (property) ->
    @model ?= @message or @schema
    @model.set property, 'value'


  @Then 'the model will have the "$property" property', (property) ->
    expect(@model.has property)


  @When 'I set the "$property" property to "$value"', (property, value) ->
    @model ?= @message or @schema
    @model.set property, value


  @Then 'the "$property" property value will equal "$value"', (property, value) ->
    expect(@model.get property).to.equal value

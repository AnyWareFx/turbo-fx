_                 = require 'underscore'
{ expect }        = require 'chai'

{ PropertyModel } = require '../../../../src/scripts/core/data'


module.exports = ->

  @Given 'I have a PropertyModel with dataType: "$dataType"', (dataType) ->
    @property = new PropertyModel dataType: dataType


  @When 'I execute the "$method" method with the value "$value"', (method, value) ->
    @model ?= @frozen or @unfrozen or @person or @message or @contact or @property
    @response = @model[method](value)


  @Then 'the response is equal to the "$property" property', (property) ->
    expect(_.isEqual(@response, @model.get property)).to.be.true


  @Then 'the "$property" property is empty', (property) ->
    expect(_.isEmpty(@model.get property)).to.be.true


  @Then 'the "$property" property equals "$value"', (property, value) ->
    expect(@model.get(property)).to.equal value

_                 = require 'underscore'
{ expect }        = require 'chai'

{ PropertyModel } = require '../../../../src/scripts/core/data'


module.exports = ->

  @Given 'I have a PropertyModel with type "$type"', (type) ->
    @property = new PropertyModel dataType: type


  @When 'I execute the "$method" method with the value "$value"', (method, value) ->
    @model ?= @frozen or @unfrozen or @person or @message or @contact or @property
    @response = @model[method](value)


  @Then 'the response is equal to "$value"', (value) ->
    expect(@response).to.equal value
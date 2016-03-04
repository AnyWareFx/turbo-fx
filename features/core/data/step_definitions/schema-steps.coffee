{ expect }       = require 'chai'
{ ContactPoint } = require '../../../support/example-models'


module.exports = ->

  @Given 'I have a ContactPoint DataModel', () ->
    @contact = new ContactPoint()


  @When 'I try to set the "$property" property to "$value"', (property, value) ->
    @model ?= @frozen or @unfrozen or @person or @message or @contact or @property
    @model.set property, value


  @When 'I execute the "$method" method', (method) ->
    @model ?= @frozen or @unfrozen or @person or @message or @contact or @property
    @response = @model[method]()


  @Then 'the response is equal to "$value"', (value) ->
    expect(@response).to.equal value


  @Then 'the "$property" property is empty', (property) ->
    expect(_.isEmpty(@model.get property)).to.be.true


  # FIXME
  @Then 'the "$property" property contains "$value"', (property, value) ->
    expect(_.findWhere(@model.get(property), message: value)).to.be.true

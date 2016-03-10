{ expect } = require 'chai'


module.exports = ->

  @When 'I observe the "$type" event', (type) ->
    @observed = null
    @model.observe type, (event) =>
      @observed = event


  @When 'I cancel the "$type" event', (type) ->
    @observed = null
    @model.observe type, ->
      true


  @Then 'the model will have the "$property" property', (property) ->
    expect(@model.has property)


  @Then 'the model will not have the "$property" property', (property) ->
    expect(not @model.has property)


  @Then 'I will receive the "$type" event', (type) ->
    expect(@observed?.type).to.equal type


  @Then 'I will not receive the "$type" event', (type) ->
    expect(@observed).to.equal null

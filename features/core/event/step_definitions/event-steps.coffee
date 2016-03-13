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


  @Then 'I will receive the "$type" event', (type) ->
    expect(@observed?.type).to.equal type


  @Then 'I will not receive the "$type" event', (type) ->
    expect(@observed).to.equal null

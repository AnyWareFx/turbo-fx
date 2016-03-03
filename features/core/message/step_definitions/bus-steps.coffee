#async     = require 'asyncawait/async'
#await     = require 'asyncawait/await'


{ expect }       = require 'chai'
{ Message, Bus } = require '../../../../src/scripts/core/message'


module.exports = ->

  @Given 'I have a Message', () ->
    @message = new Message channel: 'acceptance', topic: 'test', message: 'driven', payload: 'development'
    @message


  @Given 'I have a Message Bus', () ->
    @bus = new Bus
    @bus


  @When 'I try to set the "$property" property to "$value"', (property, value) ->
    @model = @frozen or @unfrozen or @person or @message
    @model.set property, value


  @When 'I try to add a "$property" property', (property) ->
    @model = @locked or @unlocked or @message
    @model.set property, 'value'


  @Then 'the "$property" property value will not equal "$value"', (property, value) ->
    expect(@model.get(property)).to.not.equal value

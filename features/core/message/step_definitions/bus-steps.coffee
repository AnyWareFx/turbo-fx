#async     = require 'asyncawait/async'
#await     = require 'asyncawait/await'

_                = require 'underscore'
{ expect }       = require 'chai'
{ Message, Bus } = require '../../../../src/scripts/core/message'
{ Collection }   = require '../../../../src/scripts/core/model'


module.exports = ->

  @Given 'I have "$channel" channel, "$topic" topic "$message" Message model', (channel, topic, message) ->
    @message = new Message channel: channel, topic: topic, message: message
    @message


  @Given 'I have a Message Bus', ->
    @bus = new Bus
    @bus


  @When 'I try to set the "$property" property to "$value"', (property, value) ->
    @model = @frozen or @unfrozen or @person or @message
    @model.set property, value


  @When 'I try to add a "$property" property', (property) ->
    @model = @locked or @unlocked or @message
    @model.set property, 'value'


  @When 'I subscribe to all bus messages', ->
    @received = new Collection ModelClass: Message
    @bus.subscribe new Message(), (message) ->
      @received.add message


  @When 'I subscribe to "$channel" channel messages', (channel) ->
    @received = new Collection ModelClass: Message
    @bus.subscribe new Message channel: channel, (message) ->
      @received.add message


  @When 'I subscribe to "$channel" channel and "$topic" topic messages', (channel, topic) ->
    @received = new Collection ModelClass: Message
    @bus.subscribe new Message channel: channel topic: topic, (message) ->
      @received.add message


  @When 'I subscribe to "$channel" channel, "$topic" topic and "$message" messages', (channel, topic, message) ->
    @received = new Collection ModelClass: Message
    @bus.subscribe new Message channel: channel topic: topic message: message, (message) ->
      @received.add message


  @When 'I publish a "$channel" channel, "$topic" topic and "$message" message', (channel, topic, message) ->
    @bus.publish new Message channel: channel topic: topic message: message


  @Then 'the "$property" property value will not equal "$value"', (property, value) ->
    expect(@model.get(property)).to.not.equal value


  @Then 'I will receive all bus messages', ->
    expect(@received.size).to.equal 5


  @Then 'I will receive all "$channel" channel messages', (channel) ->
    expect(@received.size).to.equal 3
    messages = @received.where channel: channel
    expect(messages.length).to.equal 3


  @Then 'I will receive all "$channel" channel and "$topic" topic messages', (channel, topic) ->
    expect(@received.size).to.equal 2
    messages = @received.where channel: channel, topic: topic
    expect(messages.length).to.equal 2


  @Then 'I will receive the "$channel" channel, "$topic" topic and "$message" message', (channel, topic, message) ->
    expect(@received.size).to.equal 1
    messages = @received.where channel: channel, topic: topic, message: message
    expect(messages.length).to.equal 1

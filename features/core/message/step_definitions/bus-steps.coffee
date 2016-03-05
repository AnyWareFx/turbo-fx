_                = require 'underscore'
{ expect }       = require 'chai'
{ Message, Bus } = require '../../../../src/scripts/core/message'
{ Collection }   = require '../../../../src/scripts/core/model'


module.exports = ->

  @Given 'I have channel: "$channel", topic: "$topic" and kind: "$kind" Message model', (channel, topic, kind) ->
    @message = new Message channel: channel, topic: topic, kind: kind
    @message


  @Given 'I have a Message Bus', ->
    @received = new Collection ModelClass: Message
    @bus = new Bus
    @bus


  @When 'I try to add a "$property" property', (property) ->
    @model = @locked or @unlocked or @message
    @model.set property, 'value'


  @When 'I try to set the "$property" property to "$value"', (property, value) ->
    @model = @frozen or @unfrozen or @person or @message
    @model.set property, value


  @When 'I subscribe to channel: "$channel", topic: "$topic" and kind: "$kind" messages', (channel, topic, kind) ->
    @received.removeAll()

    messages =
      channel: channel
      topic: topic
      kind: kind

    @bus.subscribe _.extend messages, subscription: (message) =>
      @received.add message


  @When 'I publish a channel: "$channel", topic: "$topic" and kind: "$kind" message', (channel, topic, kind) ->
    @bus.publish new Message channel: channel, topic: topic, kind: kind


  @Then 'the "$property" property value will not equal "$value"', (property, value) ->
    expect(@model.get(property)).to.not.equal value


  @Then 'I will receive all bus messages', ->
    expect(@received.size()).to.equal 5 # TODO Remove magic number


  @Then 'I will receive all channel: "$channel" messages', (channel) ->
    messages = @received.where channel: channel
    expect(@received.size()).to.equal messages.length


  @Then 'I will receive all channel: "$channel" and topic: "$topic" messages', (channel, topic) ->
    messages = @received.where channel: channel, topic: topic
    expect(@received.size()).to.equal messages.length


  @Then 'I will receive all channel: "$channel", topic: "$topic" and kind: "$kind" messages', (channel, topic, kind) ->
    messages = @received.where channel: channel, topic: topic, kind: kind
    expect(@received.size()).to.equal messages.length

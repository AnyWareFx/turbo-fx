_                = require 'underscore'
{ expect }       = require 'chai'
{ Message, Bus } = require '../../../../src/scripts/core/message'
{ Collection }   = require '../../../../src/scripts/core/model'


module.exports = ->

  @Given 'I have a Message model with channel: "$channel", topic: "$topic" and kind: "$kind"', (channel, topic, kind) ->
    @message = new Message channel: channel, topic: topic, kind: kind
    @message


  @Given 'I have a Message Bus', ->
    @received = new Collection ModelClass: Message
    @bus = new Bus
    @bus


  @When 'I subscribe to messages with channel: "$channel", topic: "$topic" and kind: "$kind"', (channel, topic, kind) ->
    @received.removeAll()

    messages =
      channel: channel
      topic: topic
      kind: kind

    @bus.subscribe _.extend messages, subscription: (message) =>
      @received.add message


  @When 'I publish a message with channel: "$channel", topic: "$topic" and kind: "$kind"', (channel, topic, kind) ->
    @bus.publish new Message channel: channel, topic: topic, kind: kind


  @Then 'I will receive all bus messages', ->
    expect(@received.size()).to.equal 5 # TODO Remove magic number


  @Then 'I will receive all messages with channel: "$channel"', (channel) ->
    messages = @received.where channel: channel
    expect(@received.size()).to.equal messages.length


  @Then 'I will receive all messages with channel: "$channel" and topic: "$topic"', (channel, topic) ->
    messages = @received.where channel: channel, topic: topic
    expect(@received.size()).to.equal messages.length


  @Then 'I will receive all messages with channel: "$channel", topic: "$topic" and kind: "$kind"', (channel, topic, kind) ->
    messages = @received.where channel: channel, topic: topic, kind: kind
    expect(@received.size()).to.equal messages.length

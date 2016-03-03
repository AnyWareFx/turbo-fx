_ = require 'underscore'


class Kind
  constructor: (@name) ->
    @subscriptions = []


  subscribe: (options = {}) ->
    { kind, subscription } = options
    if kind is @name and not _.contains @subscriptions, subscription
      @subscriptions.push subscription


  unsubscribe: (options = {}) ->


  receive: (message) ->
    if message.kind is @name
      _.each @subscriptions, (subscription) ->
        subscription message


class Topic
  constructor: (@name) ->
    @subscriptions = []
    @kinds = {}


  subscribe: (options = {}) ->
    { topic, kind, subscription } = options
    if topic is @name
      if kind is '*'
        @subscriptions.push subscription if not _.contains @subscriptions, subscription

      else
        if not _.has @kinds, kind
          @kinds[kind] = new Kind kind

        @kinds[kind].subscribe options


  unsubscribe: (options = {}) ->


  receive: (message) ->
    if message.topic is @name
      _.each @subscriptions, (subscription) ->
        subscription message

      _.each @kinds, (kind) ->
        kind.receive message


class Channel
  constructor: (@name) ->
    @subscriptions = []
    @topics = {}


  subscribe: (options = {}) ->
    { channel, topic, subscription } = options
    if channel is @name
      if topic is '*'
        @subscriptions.push subscription if not _.contains @subscriptions, subscription

      else
        if not _.has @topics, topic
          @topics[topic] = new Topic topic

        @topics[topic].subscribe options


  unsubscribe: (options = {}) ->


  receive: (message) ->
    if message.channel = @name
      _.each @subscriptions, (subscription) ->
        subscription message

      _.each @topics, (topic) ->
        topic.receive message


class Bus
  constructor: ->
    @subscriptions = []
    @channels = {}


  subscribe: (options = {}) ->
    { channel, subscription } = options
    if channel is '*'
      @subscriptions.push subscription if not _.contains @subscriptions, subscription

    else
      if not _.has @channels, channel
        @channels[channel] = new Channel channel

      @channels[channel].subscribe options


  unsubscribe: (options = {}) ->


  publish: (message) ->
    _.each @subscriptions, (subscription) ->
      subscription message

    _.each @channels, (channel) ->
      channel.receive message


module.exports = Bus

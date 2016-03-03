_         = require 'underscore'

{ Model } = require '../model'


class Message extends Model
  constructor: (properties = {}) ->
    defaults =
      channel: '*'
      topic: '*'
      kind: '*'
      payload: ''

    super _.defaults {}, properties, defaults

    @set locked: true, frozen: true


module.exports = Message

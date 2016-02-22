_     = require 'underscore'
mixin = require './emitter-mixin'


class Emitter
  constructor: ->
    _.extend @, mixin


module.exports =
  Emitter

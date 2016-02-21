_ = require 'underscore'


class Command
  constructor: (attributes) ->
    {@target, @canUndo} = _.defaults attributes, canUndo: true

  execute: ->

  undo: ->

  redo: ->
    @execute()


module.exports = Command
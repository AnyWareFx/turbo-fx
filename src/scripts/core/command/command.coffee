_ = require 'underscore'


class Command
  constructor: (params = {}) ->
    {@target, @canUndo} = _.defaults params, canUndo: true

  execute: ->

  undo: ->

  redo: ->
    @execute()


module.exports = Command

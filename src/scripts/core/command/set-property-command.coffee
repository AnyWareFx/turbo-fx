Command = require './command'


class SetPropertyCommand extends Command
  constructor: (attributes) ->
    super attributes
    {@property, @value} = attributes
    @oldValue = @target[@property]


  execute: =>
    @target[@property] = @value


  undo: =>
    @target[@property] = @oldValue


module.exports = SetPropertyCommand

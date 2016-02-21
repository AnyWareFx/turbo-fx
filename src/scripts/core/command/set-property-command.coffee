Command = require './command'


class SetPropertyCommand extends Command
  constructor: (attributes) ->
    super attributes
    {@property, @value} = attributes
    @oldValue = @target[@property]


  execute: ->
    if @target.set?
      @target.set @property, @value
    else
      @target[@property] = @value


  undo: ->
    if @target.set?
      @target.set @property, @oldValue
    else
      @target[@property] = @oldValue


module.exports = SetPropertyCommand

{ CommandContext, SetPropertyCommand } = require '../../../../src/scripts/core/command'


module.exports = ->

  @When 'I execute a command to set the "$property" property to "$value"', (property, value) ->
    @context = new CommandContext()
    @context.execute new SetPropertyCommand target: @model, property: property, value: value


  @When 'I undo the command', ->
    @context.undo()


  @When 'I redo the command', ->
    @context.redo()

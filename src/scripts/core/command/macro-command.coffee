Command = require './command'
CommandContext = require './command-context'


class MacroCommand extends Command
  constructor: (attributes) ->
    super attributes
    @context = new CommandContext()
    @commands = []


  add: (command) ->
    @commands.push command if command instanceof Command


  execute: ->
    _.each @commands, (command) =>
      @context.execute command


  undo: ->
    @context.rewind()


  redo: ->
    @context.replay()


module.exports = MacroCommand
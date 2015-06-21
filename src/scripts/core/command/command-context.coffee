Command = require './command'


class CommandContext
  constructor: ->
    @undoStack = []
    @redoStack = []


  canUndo: =>
    @undoStack.length > 0


  canRedo: =>
    @redoStack.length > 0


  execute: (command) =>
    if command instanceof Command
      command.execute()
      if command.canUndo
        @undoStack.push command
        @redoStack.length = 0


  undo: =>
    if @canUndo()
      command = @undoStack.pop()
      command.undo()
      @redoStack.push(command)


  redo: =>
    if @canRedo()
      command = @redoStack.pop()
      command.redo()
      @undoStack.push(command)


  rewind: () =>   # interval = 0
    # TODO if interval > 0 and window - setInterval or setTimeout
    @undo() while @canUndo()


  replay: () =>   # interval = 0
    # TODO if interval > 0 and window - setInterval or setTimeout
    @redo() while @canRedo()


  reset: =>
    @undoStack.length = 0
    @redoStack.length = 0


module.exports = CommandContext

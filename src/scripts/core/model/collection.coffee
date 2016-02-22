_            = require 'underscore'
Model        = require './model'
EventEmitter = require '../event/emitter'


class Collection extends EventEmitter
  @Events = _.extend Model.Events,
    ADDING:   'adding'
    ADDED:    'added'
    REMOVING: 'removing'
    REMOVED:  'removed'


  constructor: (options = {}) ->
    super options
    {@models, @ModelClass} = _.defaults options, {models: [], ModelClass: Model}
    @observers =
      adding:   []
      added:    []
      removing: []
      removed:  []
      changing: []
      changed:  []


  add: (model) ->
    if not model instanceof Model
      @add new @ModelClass model

    else if not _.contains @models, model
      cancelled = @emit
        type: Collection.Events.ADDING
        model: model

      unless cancelled
        @models.push model
        model.observe Model.Events.CHANGING, @forward
        model.observe Model.Events.CHANGED,  @forward

        @emit
          type: Collection.Events.ADDED
          model: model
    @


  remove: (model) ->
    index = _.indexOf @models, model
    if index > -1
      cancelled = @emit
        type: Collection.Events.REMOVING
        model: model

      unless cancelled
        model = @models.splice(index, 1)[0]
        model.unobserve Model.Events.CHANGING, @forward
        model.unobserve Model.Events.CHANGED,  @forward

        @emit
          type: Collection.Events.REMOVED
          model: model
    @


  forward: (event) =>
    @emit event


module.exports = Collection

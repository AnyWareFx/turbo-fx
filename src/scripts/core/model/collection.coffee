_            = require 'underscore'
Model        = require './model'
EventEmitter = require '../event/emitter'


class Collection extends EventEmitter
  @Events = _.extend {}, Model.Events,
    ADDING:   'adding'
    ADDED:    'added'
    REMOVING: 'removing'
    REMOVED:  'removed'


  constructor: (params = {}) ->
    super params
    {@models, @ModelClass} = _.defaults params, {models: [], ModelClass: Model}
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


  each: (iteratee) ->
    _.each @models, iteratee


  pluck: (propertyName) ->
    values = []
    _.each @models, (model) =>
      values.push model.get propertyName
    values


  map: (iteratee) ->
    _.map @models, iteratee

  collect: (iteratee) ->
    @map iteratee


  reduce: (iteratee, memo) ->
    _.reduce @models, iteratee, memo

  inject: (iteratee, memo) ->
    @reduce iteratee, memo


  find: (predicate) ->
    _.find @models, predicate

  detect: (predicate) ->
    @find predicate


  where: (properties) ->
    matches = []
    _.each @models, (model) =>
      matches.push model if _.isMatch model.properties, properties
    matches

  findWhere: (properties) ->
    _.find @models, (model) ->
      _.isMatch model.properties, properties


  filter: (predicate) ->
    _.filter @models, predicate

  select: (predicate) ->
    @filter predicate


  reject: (predicate) ->
    _.reject @models, predicate


  every: (predicate) ->
    _.every @models, predicate

  all: (predicate) ->
    @every predicate


  some: (predicate) ->
    _.some @models, predicate

  any: (predicate) ->
    @some predicate


  contains: (value) ->
    _.contains @models, value

  includes: (value) ->
    @contains value


  max: (iteratee) ->
    _.max @models, iteratee

  min: (iteratee) ->
    _.min @models, iteratee


  sortBy: (iteratee) ->
    _.sortBy @models, iteratee

  groupBy: (iteratee) ->
    _.groupBy @models, iteratee


  size: ->
    _.size @models


  toArray: ->
    @models


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

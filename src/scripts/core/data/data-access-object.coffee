_                     = require 'underscore'
Promise               = require 'lie'
{
  Schema,
  DataSource,
  DataModel,
  DataCollection
}                     = require './'
{ Factory }           = require '../factory'
{ Model }             = require '../model'
{ Message, Bus }      = require '../message'


defaults =
  schema: null
  dataSource: null
  dataModelName: ''
  bus: null
  locked: true


class DataAccessObject extends Model
  constructor: (properties = {}) ->
    super _.defaults {}, properties, defaults


  _valueAllowed: (name, value) ->
    (
      name is 'schema' and
        value instanceof Schema

    ) or (
      name is 'dataSource' and
        value instanceof DataSource

    ) or (
      name is 'bus' and
        value instanceof Bus

    ) or super


  set: (name, value) ->
    if arguments.length == 1
      super

    else if @_nameAllowed(name) and @_valueAllowed name, value
      switch name
        when 'schema' then @schema ?= value
        when 'dataSource' then @dataSource ?= value
        when 'bus' then @bus ?= value
      @


  create: ->
    if @schema?
      model = new DataModel
      model.set schema: @schema


  list: (criteria) ->
    @dataSource.query criteria

    .then (records) ->
      collection = new DataCollection
      _.each records, (record) =>
        model = @create()
        model.set record
        collection.add model

      Promise.resolve collection

    .catch (error) ->
      Promise.reject error


  find: (id) ->
    @dataSource.lookup id

    .then (record) =>
      model = @create()
      model.set record
      Promise.resolve model

    .catch (error) ->
      Promise.reject error


  save: (model) ->
    if model?
      if model.get('id') or model.get('_id')
        @dataSource.update model.properties

        .then (record) ->
          model.set record
          Promise.resolve model

        .catch (error) ->
          Promise.reject error

      else
        @dataSource.insert model.properties

        .then (record) ->
          model.set record
          Promise.resolve model

        .catch (error) ->
          Promise.reject error


  destroy: (id) ->
    @dataSource.destroy id



module.exports = DataAccessObject

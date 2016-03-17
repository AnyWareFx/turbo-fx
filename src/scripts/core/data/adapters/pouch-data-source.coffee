_                      = require 'underscore'
uuid                   = require 'uuid'
Promise                = require 'lie'
PouchDB                = require 'pouchdb'
PouchDBFind            = require 'pouchdb-find'

{ Schema, DataSource } = require '../'


DB = PouchDB.defaults prefix: 'db/'

DB.plugin PouchDBFind
DB.debug.enable '*'



class PouchDBDataSource extends DataSource
  constructor: (@schema) ->

  set: (properties) ->
    if properties?.schema instanceof Schema
      @schema = properties.schema

    else
      properties = _.omit properties, _.functions properties
      _.extend @, properties


  connect: (config) ->
    @db = new DB config
    if @schema?
      indexes = @schema.propertyModels.where indexed: true

      Promise.all _.each indexes, (index) =>
        @db.createIndex index: fields: [index.get 'name']

      .then -> Promise.resolve @db
      .catch (error) -> Promise.reject error

    else
      Promise.resolve @db


  disconnect: ->
    @db = null


  query: (criteria) ->
    if not @db?
      Promise.reject 'not connected'

    else if criteria? and @schema?
      @db.find criteria

    else
      @db.allDocs() # TODO determine whether to support no indexes, views


  lookup: (id) ->
    if not @db?
      Promise.reject 'not connected'

    else
      @db.get id


  insert: (record) ->
    if not @db?
      Promise.reject 'not connected'

    else
      @db.post record


  update: (record, destroy = false) ->
    if not @db?
      Promise.reject 'not connected'

    else if (record._id)
      @lookup(record._id)
        .then((found) =>
          record._rev = found._rev
          record._deleted = true if destroy

          @db.put(record).then (updated) -> Promise.resolve updated

        ).catch (error) ->
          Promise.reject error

    else
      Promise.reject 'missing _id'


  destroy: (id) ->
    if not @db?
      Promise.reject 'not connected'

    else
      @update _id: id, true



module.exports = PouchDBDataSource

_                      = require 'underscore'
uuid                   = require 'uuid'
Promise                = require 'lie'
PouchDB                = require 'pouchdb'
PouchDBFind            = require 'pouchdb-find'

{ Schema, DataSource } = require '../'


DB = PouchDB.defaults prefix: 'db/'
DB.plugin PouchDBFind

#DB.debug.enable '*'



class PouchDBDataSource extends DataSource

  @migrate: (params = {}) ->
    { config, schema } = params

    if config? and schema? and schema instanceof Schema
      db = new DB config
      count = 1
      db.createIndex index: fields: ['type']

      .then ->
        indexes = schema.propertyModels.where indexed: true

        Promise.all _.each indexes, (index) =>
          count++
          db.createIndex index: fields: [index.get 'name']

        .then ->
          Promise.resolve { message: count + ' indexes created' }

      .catch (error) ->
        Promise.reject error: error

    else
      Promise.reject error: 'missing schema and/or connection configuration'


  connect: (config) ->
    @db = new DB config


  disconnect: ->
    @db = null


  query: (criteria) ->
    if not @db?
      Promise.reject error: 'not connected'

    else if criteria?
      @db.find criteria

    else
      @db.allDocs include_docs: true # TODO determine whether to support views


  lookup: (id) ->
    if not @db?
      Promise.reject error: 'not connected'

    else
      @db.get id


  insert: (record) ->
    if not @db?
      Promise.reject error: 'not connected'

    else
      @db.post record

      .then (inserted) ->
        Promise.resolve _.extend record, _id: inserted.id, _rev: inserted.rev

      .catch (error) ->
        Promise.reject error: error


  update: (record, destroy = false) ->
    if not @db?
      Promise.reject error: 'not connected'

    else if record._id?
      @lookup record._id

      .then (found) =>
        record._rev = found._rev
        record._deleted = true if destroy

        @db.put record

        .then (updated) ->
          record._rev = updated.rev
          Promise.resolve record

      .catch (error) ->
        Promise.reject error: error

    else
      Promise.reject error: 'missing _id'


  destroy: (id) ->
    if not @db?
      Promise.reject error: 'not connected'

    else
      @update _id: id, true



module.exports = PouchDBDataSource

{ expect }        = require 'chai'
PouchDBDataSource = require '../../../../src/scripts/core/data/adapters/pouch-data-source'


id      = null
oldRev  = null
newRev  = null
object  = null
results = null


module.exports = ->

  @Given 'I have a DataSource', ->
    @pouch = new PouchDBDataSource
    @pouch


  @Given 'I migrate the Schema against the DataSource with config: "$config"', (config) ->
    PouchDBDataSource.migrate config: config, schema: @schema


  @Given 'I connect to the DataSource with config: "$config"', (config) ->
    @pouch.connect(config)


  @When 'I insert an object', ->
    oldRev = null
    @pouch.insert firstName: 'Dave', lastName: 'Jackson'

    .then (inserted) ->
      id = inserted._id
      object = inserted
      newRev = inserted._rev


  @When 'I lookup an object', ->
    oldRev = null
    @pouch.lookup id


  @When 'I update an object', ->
    oldRev = object._rev
    object.firstName = 'David'

    @pouch.update object

    .then (updated) ->
      id = updated._id
      object = updated
      newRev = updated._rev


  @When 'I query the DataSource', ->
    @pouch.query
      selector:
        firstName: 'David'
      fields: [
        '_id',
        '_rev',
        'firstName',
        'lastName'
      ]

    .then (queried) ->
      results = queried


  @When 'I destroy an object', ->
    oldRev = object._rev
    @pouch.destroy object._id

    .then (destroyed) ->
      id = destroyed._id
      object = destroyed
      newRev = destroyed._rev


  @Then 'I receive the result set', ->
    expect results?


  @Then 'the object will have a new revision', ->
#    console.log id
#    console.log object
#    console.log oldRev
#    console.log newRev
    expect oldRev is not newRev

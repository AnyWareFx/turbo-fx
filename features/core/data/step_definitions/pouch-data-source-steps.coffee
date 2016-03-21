{ expect }        = require 'chai'
PouchDBDataSource = require '../../../../src/scripts/core/data/adapters/pouch-data-source'


module.exports = ->

  @Given 'I have a DataSource', ->
    @pouch = new PouchDBDataSource
    @pouch


  @Given 'I migrate the Schema against the DataSource with config: "$config"', (config) ->
    PouchDBDataSource.migrate config: config, schema: @schema


  @Given 'I connect to the DataSource with config: "$config"', (config) ->
    @pouch.connect(config)


  @When 'I insert an object', ->
    @oldRev = null
    @pouch.insert firstName: 'Dave', lastName: 'Jackson'

    .then (object) =>
      @object = object
      @newRev = object._rev


#  @When 'I lookup an object', ->
#    @pouch.lookup @object._id


  @When 'I update an object', ->
    console.log 'update'
    console.log @object

    @oldRev = @object._rev
    @object.firstName = 'David'

    @pouch.update @object

    .then (object) =>
      @object = object
      @newRev = object._rev


#  @When 'I query an object', ->
#    @pouch.lookup @object._id


#  @When 'I destroy an object', ->
#    console.log 'destroy'
#    console.log @object

#    @oldRev = @object._rev
#    @pouch.destroy @object._id

#    .then (object) =>
#      @object = object
#      @newRev = object._rev


  @Then 'the object will have a new revision', ->
    console.log @object
    console.log @oldRev
    console.log @newRev
    expect @oldRev is not @newRev

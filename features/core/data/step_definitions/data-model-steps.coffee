{ Schema, DataModel } = require '../../../../src/scripts/core/data'


module.exports = ->

  @When 'I initialize a DataModel with the Schema', ->
    @dataModel = new DataModel()
    @dataModel.initialize @schema

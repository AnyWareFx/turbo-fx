_                     = require 'underscore'
{ expect }            = require 'chai'
{ Schema, DataModel } = require '../../../../src/scripts/core/data'


module.exports = ->

  @When 'I initialize a DataModel with the Schema', ->
    @dataModel = new DataModel()
    @dataModel.initialize @schema


  # FIXME DUP from bus-steps
#  @When 'I try to set the "$property" property to "$value"', (property, value) ->
#    @model = @frozen or @unfrozen or @person or @message or @schema # MODIFIED - copy back
#    @model.set property, value


  # FIXME DUP from bus-steps
#  @When 'I try to add a "$property" property', (property) ->
#    @model = @locked or @unlocked or @message or @dataModel # MODIFIED - copy back
#    @model.set property, 'value'


  # FIXME DUP from model-steps
#  @Then 'the model will have the "$property" property', (property) ->
#    expect(@model.has property)


  # FIXME DUP from model-steps
#  @Then 'the model will not have the "$property" property', (property) ->
#    expect(not @model.has property)

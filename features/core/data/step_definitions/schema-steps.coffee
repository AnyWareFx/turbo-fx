_                         = require 'underscore'
{ expect }                = require 'chai'
{ Schema, PropertyModel } = require '../../../../src/scripts/core/data'


responses =
  emptyResponse: {}
  errorResponse:
    email: 'invalid email address'
    date: 'invalid date'


module.exports = ->

  @Given 'I have a Schema', () ->
    @schema = new Schema()


  @Given 'I add a PropertyModel with name: "$name" and dataType: "$dataType"', (name, dataType) ->
    @schema.propertyModels.add new PropertyModel name: name, dataType: dataType


  @Then 'the JSON response is equal to $value', (value) ->
    expect(_.isEqual @response, responses[value])

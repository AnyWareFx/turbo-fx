{ expect }        = require 'chai'

{ PropertyModel } = require '../../../../src/scripts/core/data'


module.exports = ->

  @Given 'I have a PropertyModel with type "$type"', (type) ->
    @propertyModel = new PropertyModel dataType: type


  @When 'I execute the "$method" method with the value "$value"', (method, value) ->
    @model = @dataModel or @schema or @propertyModel or @message
    @response = @model[method](value)


  @Then 'the response is equal to "$value"', (value) ->
    expect(@response.toString()).to.equal value

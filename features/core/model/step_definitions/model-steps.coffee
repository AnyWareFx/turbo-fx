{ expect } = require 'chai'


module.exports = ->

  @Then 'the model will not have the "$property" property', (property) ->
    expect(not @model.has property)


  @Then 'the "$property" property value will not equal "$value"', (property, value) ->
    expect(@model.get(property)).to.not.equal value

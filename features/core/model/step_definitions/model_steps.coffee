{ expect } = require 'chai'
{ Person } = require '../../../support/example-models'


module.exports = ->

  @Given 'I have a Person model', () ->
    @person = new Person firstName: 'David', lastName: 'Jackson'
    @person


  @Given 'I have a frozen Person model', () ->
    @frozen = new Person firstName: 'David', lastName: 'Jackson', frozen: true
    @frozen


  @Given 'I have an unfrozen Person model', () ->
    @unfrozen = new Person firstName: 'David', lastName: 'Jackson'
    @unfrozen


  @Given 'I have a locked Person model', () ->
    @locked = new Person firstName: 'David', lastName: 'Jackson', locked: true
    @locked


  @Given 'I have an unlocked Person model', () ->
    @unlocked = new Person firstName: 'David', lastName: 'Jackson'
    @unlocked



  @When 'I observe the "$type" event', (type) ->
    @observed = null
    @person.observe type, (event) =>
      @observed = event


  @When 'I cancel the "$type" event', (type) ->
    @observed = null
    @person.observe type, ->
      true


  @Then 'the model will have the "$property" property', (property) ->
    expect(@model.has property)


  @Then 'the model will not have the "$property" property', (property) ->
    expect(not @model.has property)


  @Then 'I will receive the "$type" event', (type) ->
    expect(@observed?.type).to.equal type


  @Then 'I will not receive the "$type" event', (type) ->
    expect(@observed).to.equal null

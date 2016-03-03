#async     = require 'asyncawait/async'
#await     = require 'asyncawait/await'


{ expect } = require 'chai'
{ Person } = require '../support/example-models'


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



  @When 'I cancel the "$event" event', (event) ->


  @When 'I try to set the "$property" property to "$value"', (property, value) ->
    @model = @frozen or @unfrozen
    @model.set property, value


  @When 'I try to add a "$property" property', (property) ->
    @model = @locked or @unlocked
    @model.set property, 'value'


  @Then 'the "$property" property value will equal "$value"', (property, value) ->
    expect(@model.get(property)).to.equal value


  @Then 'the "$property" property value will not equal "$value"', (property, value) ->
    expect(@model.get(property)).to.not.equal value


  @Then 'the model will have the "$property" property', (property) ->
    expect(@model.has(property)).to.be.true


  @Then 'the model will not have the "$property" property', (property) ->
    expect(@model.has(property)).to.be.false


  @Then 'I will observe the "$event" event', (event) ->


  @Then 'I will not observe the "$event" event', (event) ->


  @AfterAll = ->
    console.log 'AfterAll'
    @model    = null
    @person   = null
    @locked   = null
    @frozen   = null
    @unlocked = null
    @unfrozen = null

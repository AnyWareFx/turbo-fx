zombie = require 'zombie'


World = ->
  @browser = new zombie

  @visit = (url, callback) ->
    @browser.visit url, callback
    return


module.exports = ->
  @World = World

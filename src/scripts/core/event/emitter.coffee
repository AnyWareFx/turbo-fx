_     = require 'underscore'
mixin = require './emitter-mixin'


class Emitter


_.extend Emitter.prototype, mixin


module.exports = Emitter

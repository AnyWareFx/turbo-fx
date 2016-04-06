{ Collection } = require '../model'
DataModel      = require './data-model'


class DataCollection extends Collection
  constructor: (params = {}) ->
    super _.defaults params, {models: [], ModelClass: DataModel}



module.exports = DataCollection

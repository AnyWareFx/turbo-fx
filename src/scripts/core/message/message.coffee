

class Message
  constructor: (attributes) ->
    {@channel, @topic, @message, @value} = attributes


module.exports Message
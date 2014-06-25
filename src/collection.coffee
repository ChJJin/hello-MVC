class @Collection extends @Event
  constructor: (args...)->
    super
    @init?.apply(this, args)


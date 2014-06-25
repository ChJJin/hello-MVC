class @Event
  @extend: (instancePro = {}, classPro = {})->
    class M extends @
      _.assign @::, instancePro
      _.assign @, classPro

  constructor: ()->
    @_callback = {}

  bind: (event, cb)->
    events = event.split(' ')
    @_callback ?= {}
    for name in events
      @_callback[name] ?= []
      @_callback[name].push cb
    this

  trigger: (event, args...)->
    for e in (@_callback[event] ? [])
      e.apply @, args
    this

  unbind: (event, cb)->
    unless event
      @_callback = {}
    else unless cb
      @_callback ?= {}
      events = event.split(' ')
      for name in events
        @_callback[name] = []
    else
      events = event.split(' ')
      for name in events
        for e, i in (@_callback?[name] ? []) when e is cb
          @_callback[name].splice i, 1
    this

  after: (event, times, cb)->
    if times is 0 then return cb.apply(this, [])
    results = []
    afterCb = (result)->
      results.push(result)
      if --times < 1
        cb.call(this, results)
        @unbind(event, afterCb)
    @bind(event, afterCb)
    this

  once: (event, cb)->
    @after(event, 1, cb)

@Event.on = @Event.bind
@Event.off = @Event.unbind
@Event.fire = @Event.trigger

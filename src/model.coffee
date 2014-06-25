class @Model extends @Event
  constructor: (attrs, option)->
    super
    @init?.apply(this, args)
    @_attributes = {}
    attrs = _.assign {}, attrs, @default
    @set(attrs, option)

  get: (attr)->
    @_attributes[attr]

  set: (key, val, option = {})->
    if _.isObject(key)
      attrs = key
      option = val
    else
      (attrs = {})[key] = val

    unless @_validate(attrs, option) then return false

    @_previousAttrs = _.clone @_attributes, true
    @_attributes = _.assign {}, @_attributes, attrs
    @fire('change', this)

    this

  _validate: (attrs, option = {})->
    if option.validate
      error = option.validate(attrs)
    if (not error) and @validate
      error = @validate(attrs)

    @fire('validate', this, error)
    return if error then false else true

  toJSON: ()->
    _.clone @_attributes, true

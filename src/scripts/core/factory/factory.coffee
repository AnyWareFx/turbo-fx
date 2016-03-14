_ = require 'underscore'


class Delegate

  constructor: (params = {}) ->
    {@classes, @templates} = _.defaults params, classes: {}, templates: []
    @singletons = {}
    @templateCache = {}


  getComponent: (name) ->
    component = @singletons[name]

    unless component?
      try
        template = @getTemplate name

        if template?.ClassName?
          component = new @classes[template.ClassName]()

          @setExtendedProperties component, template
          @injectDependencies component, template
          @setProperties component, template

          if template.singleton?
            @singletons[name] = component

          # else
            # TODO Log 'not found or missing class name'

      catch error
        # TODO Log error

    component


  getTemplate: (name) ->
    template = @templateCache[name]

    unless template?
      template = _.findWhere @templates, { componentName: name }
      @templateCache[name] = template if template?

    # TODO Log not found

    template


  setExtendedProperties: (component, template) ->
    extensions = []
    extension = template

    while extension.extend
      extension = @getTemplate extension.extend
      extensions.push extension

    while extensions.length
      extension = extensions.pop()
      @injectDependencies component, extension
      @setProperties component, extension

    component


  injectDependencies: (component, template) ->
    if template.dependencies?
      for dependency in template.dependencies
        reference = @getComponent dependency.reference
        @setProperty component, dependency.propertyName, reference

    component


  setProperties: (component, template) ->
    if template.properties?
      if component.set?
        component.set template.properties
      else
        _.extend component, template.properties

    if template.details?
      for detail in template.details
        @setDetailProperty component, detail

    component


  setProperty: (component, name, value) ->
    if component.set?
      component.set name, value
    else
      component[name] = value

    component


  setDetailProperty: (component, property) ->
    if property.DetailClassName? and property.ItemClassName?

      DetailClass = @classes[property.DetailClassName]
      ItemClass = @classes[property.ItemClassName]

      if DetailClass? and ItemClass?
        details = new DetailClass()
        details.ModelClass = ItemClass if details.ModelClass?

        for template in property.items
          item = new ItemClass()

          @injectDependencies item, template
          @setProperties item, template

          if details.push?
            details.push item

          else if details.add?
            details.add item

        @setProperty component, property.propertyName, details

    component



class Factory
  instance = null

  @initialize: (classes, templates) ->
    instance = new Delegate(classes, templates) unless instance?

  @get: (name) ->
    instance.getComponent name




module.exports = Factory

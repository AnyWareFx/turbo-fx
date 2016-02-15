#Backbone = require 'backbone'
_ = require 'underscore'


class Factory
  @instance = new Factory()

  constructor: ->
    @specs = []
    @classes = {}
    @templates = {}
    @singletons = {}


  @getInstance: ->
    @instance


  initialize: (classes, specs) ->
    @classes = classes if _.isEmpty @classes and _.isObject classes
    @specs = specs if _.isEmpty @specs and _.isArray specs


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

#        else
          # TODO Log 'not found or missing class name'

      catch error
        # TODO Log error

    component


  getTemplate: (name) ->
    template = @templates[name]

    unless template?
      template = _.findWhere @specs, { name: name }
      @templates[name] = template if template?

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


  injectDependencies: (component, template) ->
    if template.dependencies?
      for dependency in template.dependencies
        reference = @getComponent dependency.reference
        component[dependency.name] = reference


  setProperties: (component, template) ->
    if template.properties?
      for property in template.properties
        if property.value?
          component[property.name] = property.value

        else if property.type is 'Array'
          @setArrayProperty component, property


  setArrayProperty: (component, property) ->
    if property.ClassName?
      elements = []
      ElementClass = @classes[property.ClassName]

      for template in property.element
        element = new ElementClass()
        @injectDependencies element, template
        @setProperties element, template
        elements.push element

      component[property.name] = elements


module.exports = Factory

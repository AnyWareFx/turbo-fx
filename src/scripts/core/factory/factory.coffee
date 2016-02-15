Backbone = require 'backbone'
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
      template = _.findWhere @specs, { componentName: name }
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

    component


  injectDependencies: (component, template) ->
    if template.dependencies?
      for dependency in template.dependencies
        reference = @getComponent dependency.reference
        @setProperty component, dependency.propertyName, reference

    component


  setProperties: (component, template) ->
    if template.properties?
      if component instanceof Backbone.Model
        component.set template.properties
      else
        _.extend component, template.properties

    if template.details?
      for detail in template.details
        @setDetailProperty component, detail

    component


  setProperty: (component, name, value) ->
    if component instanceof Backbone.Model
      component.set name, value
    else
      component[name] = value


  setDetailProperty: (component, property) ->
    if property.ClassName?
      details = []
      DetailClass = @classes[property.ClassName]

      for template in property.items
        detail = new DetailClass()
        @injectDependencies detail, template
        @setProperties detail, template
        details.push detail

      @setProperty component, property.propertyName, details

    component


module.exports = Factory

Backbone = require 'backbone'
_ = require 'underscore'


class Delegate

  constructor: (classes, specs) ->
    @specs = specs
    @classes = classes
    @templates = {}
    @singletons = {}


  get: (name) ->
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
        reference = @get dependency.reference
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

    component


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



class Factory
  instance = null

  @initialize: (classes, specs) ->
    instance = new Delegate(classes, specs) unless instance?

  @get: (name) ->
    instance.get name




module.exports = Factory

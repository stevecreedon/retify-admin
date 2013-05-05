angular.module('lovebnb.factories.model', ['ngResource'])
  .factory('$model', ['$resource', '$location', ($resource, $location) ->
    Model = (url, options) ->
      options = {} unless options
      params  = { id: '@id' }
      params  = angular.extend( params, options['params'] ) if options['params']

      actions = { new: { method: 'GET', isArray: false } }
      actions = angular.extend( actions, options['actions'] ) if options['actions']

      this.model = $resource( url, params, actions )

      this.build = ( attributes ) ->
        this.model = new model( attributes )

      this.$new = ( params ) ->
        model.$new angular.extend({ id: 'new' }, params), ( ( value, header ) ->
          options['success']( value, header ) if options['success']
        ), ( ( response ) ->
          options['error']( response ) if options['error']
        )

      return this

#      @success = ( value, header ) ->
#        console.log 'hey'
#
#      @error = ( response ) ->
#        console.log 'error'
#
#      Resource = (value) ->
#        @$ngresource = @$ngresource(value)
#
#      Resource['$ngresource'] = resource
#      Resource['$new'] = (params, options) ->
#        @resource.$new angular.extend({ id: 'new' }, params), ( ( value, header ) ->
#          @success(value, header)
#          options['success']( value, header ) if options['success']
#        ), ( ( response ) ->
#          @error(response)
#          options['error']( response ) if options['error']
#        )
#      Resource['$find']     = (params) ->
#        @resource.$query(params, @success, @error)
#      Resource['$save']     = (params) ->
#        if @resource.id
#          @resource.$update(params, @success, @error)
#        else
#          @resource.$save(params, @success, @error)
#
#
#
#      return Resource
  ])
  .factory('$model_instance', ['$resource', '$location', ($resource, $location) ->
    'hey'
  ])
  .factory('$model_instances', ['$resource', '$location', ($resource, $location) ->
    'hey'
  ])
# 
#  .factory('Property', ($model) ->
#    $model 'property',
#      namespace: '/api',
#      plurals: 'properties',
#      validations:
#        title:       { required: true }
#        description: { required: true }
#  )
#  Property.new  { some: attributes }
#  Property.get  { id }
#  Property.find { some: attributes }
#  property.valid
#  property.save

#  .factory('PropertyPhoto', ($model) ->
#    $model ['property', 'photo'],
#      namespace: '/api',
#      plurals: ['properties', 'photos'],
#      validations:
#        title:       { required: true }
#        description: { required: true }
#  )
#  PropertyPhoto.new  { property_id: xxx, some: attributes }
#  Property.get  { id }
#  Property.find { some: attributes, property_id: xxx }
#  property.valid
#  property.save

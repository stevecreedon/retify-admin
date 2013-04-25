angular.module('lovebnb.factories.model', ['ngResource'])
  .factory('$model', ['$resource', '$location', ($resource, $location) ->
    'hey'
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

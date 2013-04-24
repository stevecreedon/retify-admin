window.PropertiesController = ($scope, Property) ->
  $scope.properties = Property.query()

  $scope.set_body_class 'properties'

window.PropertiesController.$inject = ['$scope', 'Property']

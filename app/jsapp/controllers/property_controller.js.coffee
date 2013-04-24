window.PropertyController = ($scope, $routeParams, Property, PropertyPhoto) ->
  $scope.to_md = (text) ->
    marked.parser(marked.lexer(text)) if text

  $scope.property = Property.get property_id: $routeParams.id, ->
    $scope.property_cached = angular.copy $scope.property
    jQuery ->
      $('#fileupload').fileupload
        dataType: 'json'
        headers: { 'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content') }
        url: "/api/properties/#{$scope.property_cached.id}/photos"
        add: (e, data) ->
          data.submit()
        done: (e, data) ->
          $.each data.result, (index, file) ->
            $scope.$apply (scope) ->
              scope.property.photos.push(new PropertyPhoto(file))

  $scope.set_body_class 'properties'

  $scope.$watch 'is_title_editable', (new_value, old_value) ->
    if new_value == false && old_value == true && $scope.property.title != $scope.property_cached.title
      $scope.property_cached.title = $scope.property.title
      $scope.property_cached.$update()

  $scope.$watch 'is_description_editable', (new_value, old_value) ->
    if new_value == false && old_value == true && $scope.property.description != $scope.property_cached.description
      $scope.property_cached.description = $scope.property.description
      $scope.property_cached.$update()

  $scope.$watch 'is_address_editable', (new_value, old_value) ->
    if new_value == false &&
       old_value == true &&
       ( $scope.property.address.address != $scope.property_cached.address.address ||
         $scope.property.address.city != $scope.property_cached.address.city ||
         $scope.property.address.country != $scope.property_cached.address.country ||
         $scope.property.address.post_code != $scope.property_cached.address.post_code )
      $scope.property_cached.address = angular.copy $scope.property.address
      $scope.property_cached.$update()

  $scope.hey = ->
    console.log $scope.property

window.PropertyController.$inject = ['$scope', '$routeParams', 'Property', 'PropertyPhoto']

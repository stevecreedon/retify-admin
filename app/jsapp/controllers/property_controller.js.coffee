window.PropertyController = ($scope, $routeParams, Property) ->
  $scope.to_md = (text) ->
    marked.parser(marked.lexer(text)) if text

  $scope.property = Property.get property_id: $routeParams.id, ->
    $scope.property_cached = angular.copy $scope.property

  $scope.set_body_class 'properties'

  $scope.active_type = 'property'
  $scope.active_key  = 'home'
  $scope.active_view = '/assets/views/property/home.html'
  $scope.show = (type, key) ->
    $scope.active_type = type
    $scope.active_key  = key
    $scope.active_view = switch type
      when 'property'
        switch key
          when 'home'        then '/assets/views/property/home.html'
          when 'title'       then '/assets/views/property/title.html'
          when 'description' then '/assets/views/property/description.html'
      when 'photos'
        switch key
          when 'all'         then '/assets/views/property/photos.html'
      when 'address'
        switch key
          when 'all'         then '/assets/views/property/address.html'
      when 'directions'
        switch key
          when 'add'
            '/assets/views/property/direction_add.html'
          else
            $scope.direction_cached = $scope.find_direction_by_title(key)
            $scope.direction        = angular.copy $scope.direction_cached
            '/assets/views/property/direction.html'

  $scope.active_menu = (type, key) ->
    'active' if $scope.active_type == type && $scope.active_key == key

  $scope.find_direction_by_title = (title) ->
    for direction in $scope.property_cached.directions
      if direction.title == title
        return direction

  # property saving section

  $scope.save_property = () ->
    $scope.property_cached = angular.copy $scope.property
    $scope.property_cached.$update {}, (->) , $scope.process_error_response

  $scope.process_error_response = (response) ->
    switch response.status
      when 400
        $scope.server_errors = response.data.errors.full_messages
      when 404
        $location.path('/404')
      else
        $location.path('/500')

window.PropertyController.$inject = ['$scope', '$routeParams', 'Property']

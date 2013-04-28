window.PropertyController = ($scope, $routeParams, Property) ->
  $scope.to_md = (text) ->
    marked.parser(marked.lexer(text)) if text

  $scope.property = Property.get property_id: $routeParams.id, ->
    $scope.property_cached = angular.copy $scope.property

  $scope.set_body_class   'properties'

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
          when 'new'         then '/assets/views/property/direction_new.html'
          else
            $scope.direction_cached = $scope.find_by( 'title', key, $scope.property_cached.directions)
            $scope.direction        = angular.copy $scope.direction_cached
            '/assets/views/property/direction.html'
      when 'pages'
        switch key
          when 'new'         then '/assets/views/property/page_new.html'
          else
            $scope.page_cached = $scope.find_by( 'title', key, $scope.property.articles)
            $scope.page        = angular.copy $scope.page_cached
            '/assets/views/property/page.html'
      when 'calendars'
        switch key
          when 'new'         then '/assets/views/property/calendar_new.html'
          else
            $scope.calendar_cached = $scope.find_by( 'provider', key, $scope.property.calendars)
            $scope.calendar        = angular.copy $scope.calendar_cached
            '/assets/views/property/calendar.html'

  $scope.active_menu = (type, key) ->
    'active' if $scope.active_type == type && $scope.active_key == key

  $scope.find_by = ( field, value, collection) ->
    for item in collection
      if item[field] == value
        return item

  # property saving section

  $scope.save_property = () ->
    $scope.property_cached = angular.copy $scope.property
    $scope.property_cached.$update {}, (->) , $scope.process_error_response

window.PropertyController.$inject = ['$scope', '$routeParams', 'Property']

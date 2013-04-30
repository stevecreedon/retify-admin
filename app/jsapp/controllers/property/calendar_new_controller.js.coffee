window.PropertyCalendarNewController = ($scope, PropertyCalendar) ->
  $scope.calendar = new PropertyCalendar({ property_id : $scope.property.id })

  $scope.save = () ->
    $scope.calendar.$save ( (resource, header) ->
      $scope.calendar = resource
      $scope.property_cached.calendars.push($scope.calendar)
      $scope.property.calendars = angular.copy $scope.property_cached.calendars
      $scope.show('calendars', $scope.calendar.provider)
    ), $scope.process_error_response

  $scope.reset = () ->
    $scope.calendar = new PropertyCalendar({ property_id : $scope.property.id })

  $scope.cancel = () ->
    $scope.reset()
    $scope.show('property', 'home')

window.PropertyCalendarNewController.$inject = ['$scope', 'PropertyCalendar']

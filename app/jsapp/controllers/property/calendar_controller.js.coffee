window.PropertyCalendarController = ($scope, PropertyCalendar) ->
  $scope.save = () ->
    if $scope.is_changed()
      new PropertyCalendar($scope.calendar).$update ( (resource, header) ->
        $scope.calendar        = resource
        $scope.calendar_cached = angular.copy $scope.calendar.provider
      ), $scope.process_error_response

  $scope.reset = () ->
    $scope.calendar.provider = $scope.calendar_cached.provider
    $scope.calendar.path     = $scope.calendar_cached.path

  $scope.cancel = () ->
    $scope.reset()
    $scope.show('property', 'home')

  $scope.is_changed = () ->
    $scope.calendar.provider != $scope.calendar_cached.provider ||
    $scope.calendar.path     != $scope.calendar_cached.path

window.PropertyCalendarController.$inject = ['$scope', 'PropertyCalendar']

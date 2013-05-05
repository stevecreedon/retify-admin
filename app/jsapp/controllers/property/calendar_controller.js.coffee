window.PropertyCalendarController = ($scope, PropertyCalendar) ->
  $scope.submited = false

  $scope.save = () ->
    $scope.submited = true
    if $scope.form.$valid && $scope.is_changed()
      new PropertyCalendar($scope.calendar).$update (resource, header) ->
        $scope.calendar        = resource
        $scope.calendar_cached.provider = $scope.calendar.provider
        $scope.calendar_cached.path     = $scope.calendar.path
        $scope.notify.success text: 'Calendar was saved'

  $scope.reset = () ->
    $scope.submited = false
    $scope.calendar.provider = $scope.calendar_cached.provider
    $scope.calendar.path     = $scope.calendar_cached.path

  $scope.cancel = () ->
    $scope.reset()
    $scope.show('property', 'home')

  $scope.is_changed = () ->
    $scope.calendar.provider != $scope.calendar_cached.provider ||
    $scope.calendar.path     != $scope.calendar_cached.path

window.PropertyCalendarController.$inject = ['$scope', 'PropertyCalendar']

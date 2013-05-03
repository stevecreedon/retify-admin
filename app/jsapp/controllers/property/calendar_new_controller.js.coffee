window.PropertyCalendarNewController = ($scope, PropertyCalendar) ->
  $scope.calendar = new PropertyCalendar({ property_id : $scope.property.id })
  $scope.submited = false

  $scope.save = () ->
    $scope.submited = true
    if $scope.form.$valid
      $scope.calendar.$save ( (resource, header) ->
        $scope.calendar = resource
        $scope.property_cached.calendars.push($scope.calendar)
        $scope.property.calendars = angular.copy $scope.property_cached.calendars
        $scope.show('calendars', $scope.calendar.provider)
        $scope.notify text: 'Calendar was created'
      ), $scope.process_error_response

  $scope.reset = () ->
    $scope.submited = false
    $scope.calendar = new PropertyCalendar({ property_id : $scope.property.id })

  $scope.cancel = () ->
    $scope.reset()
    $scope.show('property', 'home')

window.PropertyCalendarNewController.$inject = ['$scope', 'PropertyCalendar']

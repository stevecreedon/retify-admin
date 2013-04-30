window.FeedsPropertyCalendarNewController = ($scope, PropertyCalendar) ->
  $scope.model = PropertyCalendar.new( { property_id: $scope.feed.parent_id } )
  $scope.submited = false

  $scope.save = () ->
    $scope.submited = true
    $scope.process_saving($scope, { property_id: $scope.feed.parent_id })

  $scope.cancel = ->
    $scope.submited = false
    $scope.model    = PropertyCalendar.new( { property_id: $scope.feed.parent_id } )

window.FeedsPropertyCalendarNewController.$inject = ['$scope', 'PropertyCalendar']

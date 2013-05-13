window.AccountController = ($scope, $location, User) ->
  $location.path('/feeds') if $scope.current_user.name && $scope.current_user.phone
  $scope.user = new User(angular.copy($scope.current_user))

  $scope.set_body_class   'properties'
  $scope.submited       = false

  $scope.save = () ->
    $scope.submited     = true
    if $scope.form.$valid
      $scope.block()
      $scope.user.$update (response, headers) ->
        $scope.load_user(response)
        $scope.submited = false
        $scope.notify.success text: 'Account was successfully created.'
        $scope.unblock()
        $location.path('/feeds')

  $scope.cancel = ->
    $scope.submited     = false
    $scope.user     = new User(angular.copy($scope.current_user))

window.AccountController.$inject = ['$scope', '$location', 'User']

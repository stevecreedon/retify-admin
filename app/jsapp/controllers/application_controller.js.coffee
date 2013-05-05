window.ApplicationController = ($scope, $location, Notify, Messages, DataLoader, Site) ->
  $scope.init = ->
    $scope.notify   = Notify
    $scope.messages = Messages
    $scope.set_body_class('feeds')
    $scope.load_user()
    $scope.current_site = new Site(DataLoader.from_meta('site'))

  $scope.load_user = ->
    $scope.current_user = DataLoader.from_meta('current-user')

    window.location = '/session/sign_in' unless $scope.current_user

    if $scope.current_user.password_identity && $scope.current_user.password_identity.state == 'verifying'
      $scope.notify.alert text: $scope.messages.user.verify, timeout: 10000

  $scope.set_body_class = (class_name)->
    $scope.body_class = class_name

  $scope.process_error_response = (response) ->
    switch response.status
      when 400
        response.config.data.errors = response.data.errors
        for error in response.data.errors
          $scope.notify.alert text: error
      when 404
        $location.path('/404')
      else
        $location.path('/500')

   $scope.init()
window.ApplicationController.$inject = ['$scope', '$location', 'Notify', 'Messages', 'DataLoader', 'Site']

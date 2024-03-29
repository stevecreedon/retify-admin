window.VerificationController = ($scope, $http, $location) ->
  $scope.set_body_class 'properties'

  $scope.send_again = ->
    $scope.block()
    $http({ method: 'GET', url: '/api/registration/send_again' }).
      success( (data, status, headers, config) ->
        $scope.notify.success text: 'Verification email sent'
        $scope.unblock()
      ).
      error( (data, status, headers, config) ->
        $scope.unblock()
        switch status
          when 401
            window.location = '/session/sign_in'
          when 404
            $location.path('/404')
          else
            $location.path('/500')

      )

window.VerificationController.$inject = ['$scope', '$http', '$location']

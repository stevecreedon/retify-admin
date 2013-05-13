angular.module('lovebnb.factories.http_interceptor', [])
  .factory('http_interceptor', [ '$q', '$location', 'Notify', ($q, $location, Notify) ->
    (promise) ->
      promise.then(( (response) ->
        return response
      ), ( (response) ->
        if response.status
          switch response.status
            when 400
              if response.data && response.data.errors
                response.config.data.errors = response.data.errors
                for error in response.data.errors
                  Notify.alert text: error
            when 401
              window.location = '/session/sign_in'
            when 404
              $location.path('/404')
            else
              $location.path('/500')
          $.unblockUI()
        return $q.reject(response)
      ))
  ])
  .config(['$httpProvider', ($httpProvider) ->
    $httpProvider.responseInterceptors.push('http_interceptor')
  ])

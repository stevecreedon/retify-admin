angular.module('lovebnb.routes', [])
  .config(['$routeProvider', '$httpProvider', ($routeProvider, $httpProvider) ->
    $routeProvider.when('/feeds',
      templateUrl: '/assets/views/feeds.html',
      controller: @FeedsController
    )
    $routeProvider.when('/server_page_not_found',
      templateUrl: '/assets/views/404.html',
      controller: @ErrorsController
    )
    $routeProvider.when('/server_error',
      templateUrl: '/assets/views/500.html',
      controller: @ErrorsController
    )
    $routeProvider.otherwise({ redirectTo: '/feeds' })

    # setting csrf token for rails csrf protection
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
    return
  ])

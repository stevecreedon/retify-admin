angular.module('lovebnb.routes', [])
  .config(['$routeProvider', '$httpProvider', ($routeProvider, $httpProvider) ->
    $routeProvider.when('/feeds',
      templateUrl: '/assets/views/feeds.html',
      controller: @FeedsController
    )
    $routeProvider.when('/properties',
      templateUrl: '/assets/views/properties.html',
      controller: @PropertiesController
    )
    $routeProvider.when('/properties/:id',
      templateUrl: '/assets/views/property.html',
      controller: @PropertyController
    )
    $routeProvider.when('/404',
      templateUrl: '/assets/views/404.html',
      controller: @ErrorsController
    )
    $routeProvider.when('/500',
      templateUrl: '/assets/views/500.html',
      controller: @ErrorsController
    )
    $routeProvider.otherwise({ redirectTo: '/feeds' })

    # setting csrf token for rails csrf protection
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
    return
  ])

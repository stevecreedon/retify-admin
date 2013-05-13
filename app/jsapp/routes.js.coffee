angular.module('lovebnb.routes', [])
  .config(['$routeProvider', '$httpProvider', ($routeProvider, $httpProvider) ->
    $routeProvider.when '/feeds',
      templateUrl: '/assets/views/feeds.html',            controller: @FeedsController
    $routeProvider.when '/settings',
      templateUrl: '/assets/views/settings.html',         controller: @SettingsController
    $routeProvider.when '/account_settings',
      templateUrl: '/assets/views/account_settings.html', controller: @AccountSettingsController
    $routeProvider.when '/account',
      templateUrl: '/assets/views/account.html',          controller: @AccountController
    $routeProvider.when '/properties',
      templateUrl: '/assets/views/properties.html',       controller: @PropertiesController
    $routeProvider.when '/properties/:id',
      templateUrl: '/assets/views/property.html',         controller: @PropertyController
    $routeProvider.when '/verification',
      templateUrl: '/assets/views/verification.html',     controller: @VerificationController
    $routeProvider.when '/404',
      templateUrl: '/assets/views/404.html',              controller: @ErrorsController
    $routeProvider.when '/500',
      templateUrl: '/assets/views/500.html',              controller: @ErrorsController
    $routeProvider.otherwise({ redirectTo: '/feeds' })

    # setting csrf token for rails csrf protection
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
    return
  ])

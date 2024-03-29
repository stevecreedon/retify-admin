angular.module('lovebnb.models', ['ngResource'])
  .factory('User', ['$resource', ($resource) ->
    $resource '/api/users/:user_id', { user_id:'@id' }
  ])
  .factory('Feed', ['$resource', ($resource) ->
    $resource '/api/feeds/:feed_id', { feed_id:'@id' }
  ])
  .factory('Site', ['$resource', ($resource) ->
    $resource '/api/sites/:site_id', { site_id:'@id' },
      new:
        method: 'GET', isArray: false, url: '/api/sites/new'
  ])
  .factory('Property', ['$resource', ($resource) ->
    $resource '/api/properties/:property_id', { property_id:'@id' },
      new:
        method: 'GET', isArray: false, url: '/api/properties/new'
  ])
  .factory('PropertyPhoto', ['$resource', ($resource) ->
    $resource(
      '/api/properties/:property_id/photos/:photo_id',
      { property_id:'@property_id', photo_id:'@id' }
    )
  ])
  .factory('PropertyCalendar', ['$resource', ($resource) ->
    $resource(
      '/api/properties/:property_id/calendars/:calendar_id',
      { property_id:'@property_id', calendar_id:'@id' },
      { new:
          method: 'GET', isArray: false, url: '/api/properties/:property_id/calendars/new'
      }
    )
  ])
  .factory('PropertyArticle', ['$resource', ($resource) ->
    $resource(
      '/api/properties/:property_id/articles/:article_id',
      { property_id:'@source_id', article_id:'@id' },
      { new:
          method: 'GET', isArray: false, url: '/api/properties/:property_id/articles/new'
      }
    )
  ])
  .factory('PropertyDirection', ['$resource', ($resource) ->
    $resource(
      '/api/properties/:property_id/directions/:direction_id',
      { property_id:'@property_id', direction_id:'@id' },
      { new:
          method: 'GET', isArray: true, url: '/api/properties/:property_id/directions/new'
      }
    )
  ])
  .factory('Address', ['$resource', ($resource) ->
    $resource '/api/addresses/:address_id', { address_id: '@id' }
  ])
  .factory('Identity', ['$resource', ($resource) ->
    $resource '/api/identities/:identity_id', { identity_id: '@id' }
  ])



angular.module('lovebnb.models', ['ngResource'])
  .factory('Feed', ($resource) ->
    $resource '/api/feeds/:feed_id', { feed_id:'@id' }
  )
  .factory('Site', ($resource) ->
    $resource '/api/sites/:site_id', { site_id:'@id' },
      new:
        method: 'GET', isArray: false, url: '/api/sites/new'
  )
  .factory('Property', ($resource) ->
    $resource '/api/properties/:property_id', { property_id:'@id' },
      new:
        method: 'GET', isArray: false, url: '/api/properties/new'
  )
  .factory('PropertyCalendar', ($resource) ->
    $resource(
      '/api/properties/:property_id/calendars/:calendar_id',
      { property_id:'@property_id', calendar_id:'@calendar_id' },
      { new:
          method: 'GET', isArray: false, url: '/api/properties/:property_id/calendars/new'
      }
    )
  )
  .factory('Address', ($resource) ->
    $resource '/api/addresses/:address_id', { address_id:'@id' }
  )



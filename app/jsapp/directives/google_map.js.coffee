angular.module('lovebnb.directives.google_map', [])
  .directive 'googleMap', [ 'Geocode', (Geocode) ->
    restrict: 'E'
    scope:
      address: '='
      addresses: '='
      mapId: '@'
    templateUrl: '/assets/views/google_map/index.html'
    link: (scope, element, attrs) ->
      scope.show_map = (scope, lat, lng) ->
        scope.latlng  = new google.maps.LatLng(lat, lng)

        google.maps.event.clearListeners(scope.map, 'idle') if scope.map

        options =
          zoom: 14
          center: scope.latlng
          mapTypeId: google.maps.MapTypeId.ROADMAP

        scope.map = new google.maps.Map document.getElementById(attrs.mapId), options

        if scope.marker
          google.maps.event.clearListeners(scope.marker, 'dragend')
          scope.marker.setMap(null)
          scope.marker = null

        google.maps.event.addListener scope.map, 'idle', () ->

          unless scope.marker
            scope.marker  = new google.maps.Marker
              position: scope.latlng
              map: scope.map
              draggable: true

            google.maps.event.addListener scope.marker, "dragend", () ->
              scope.$apply ->
                scope.address.user_set_lat = scope.marker.getPosition().lat()
                scope.address.user_set_lng = scope.marker.getPosition().lng()
              return
            return
          return
        return

      scope.location_changed = (new_address, old_address) ->
        return false unless new_address && old_address
        return !(new_address.lat == old_address.lat && new_address.lng == old_address.lng)

      window.scope = scope

      scope.$watch 'address', (new_address, old_address) ->
        if scope.location_changed(new_address, old_address) || # location is changed
           (new_address && !old_address && new_address.lat) || # there is no old_address and new address have coordinaates
           (new_address && new_address.lat && !scope.map)      # map is not displayed yet 
          scope.show_map(scope, new_address.user_set_lat || new_address.lat, new_address.user_set_lng || new_address.lng)

        return

      , true

      return
  ]

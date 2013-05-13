angular.module('lovebnb.directives.google_map', [])
  .directive 'googleMap', [ 'Geocode', (Geocode) ->
    restrict: 'E'
    scope:
      address: '='
      addresses: '='
      mapId: '@'
    templateUrl: '/assets/views/google_map/index.html'
    link: (scope, element, attrs) ->
      window.scope = scope
      scope.$watch 'address', (value) ->
        if value
          scope.address = value

          if scope.address.user_set_lat
            latlng  = new google.maps.LatLng(scope.address.user_set_lat, scope.address.user_set_lng)
          else
            latlng  = new google.maps.LatLng(scope.address.lat, scope.address.lng)

          unless scope.map
            options =
              zoom: 14,
              center: latlng,
              mapTypeId: google.maps.MapTypeId.ROADMAP

            scope.map = new google.maps.Map document.getElementById(attrs.mapId), options

          if scope.marker
            scope.marker.setPosition(latlng)
          else
            scope.marker  = new google.maps.Marker
              position: latlng
              map: scope.map
              draggable: true

            google.maps.event.addListener scope.marker, "dragend", () ->
              scope.$apply ->
                scope.address.user_set_lat = scope.marker.getPosition().lat()
                scope.address.user_set_lng = scope.marker.getPosition().lng()

          google.maps.event.trigger(scope.map, 'resize')
          scope.map.setCenter(latlng)

      , true

      return
  ]

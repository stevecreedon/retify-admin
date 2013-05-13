angular.module('lovebnb.factories.geocode', [])
  .factory 'Geocode', () ->

    () ->
      geocoder: new google.maps.Geocoder()
      timeout_id: null
      find_with_timeout: (address, timeout, success, error) ->
        window.clearTimeout(this.timeout_id) if this.timeout_id
        self = this
        this.timeout_id = window.setTimeout((() -> self.find(address, success, error)) , timeout)
      find: (address, success, error) ->
        return unless address
        address_array = [ address.address, address.city, address.post_code, address.country ].filter((x) -> x != undefined && x != '')
        if address_array.length == 4
          this.geocoder.geocode address: address_array.join(', '), (results, status) ->
            switch status
              when google.maps.GeocoderStatus.OK
                res = []
                for result in results
                  if result.geometry.location_type in [google.maps.GeocoderLocationType.ROOFTOP, google.maps.GeocoderLocationType.RANGE_INTERPOLATED]
                    res.push
                      google_formatted_address: result.formatted_address
                      lat: result.geometry.location.lat()
                      lng: result.geometry.location.lng()
                      user_set_lat: undefined
                      user_set_lng: undefined
                if res.length == 1
                  success(res[0]) if success
                else
                  error(res) if error
              when google.maps.GeocoderStatus.ZERO_RESULTS
                success([]) if error
              when google.maps.GeocoderStatus.ERROR, google.maps.GeocoderStatus.INVALID_REQUEST, google.maps.GeocoderStatus.OVER_QUERY_LIMIT, google.maps.GeocoderStatus.REQUEST_DENIED, google.maps.GeocoderStatus.UNKNOWN_ERROR
                error([]) if error
        else
          success([]) if success


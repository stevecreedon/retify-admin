window.FeedsPropertyPhotoNewController = ($scope, PropertyPhoto) ->
  $scope.photos = PropertyPhoto.query( { property_id: $scope.feed.parent_id } )

  jQuery ->
    $('#fileupload').fileupload
      dataType: 'json'
      headers: { 'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content') }
      url: "/api/properties/#{$scope.feed.parent_id}/photos"
      add: (e, data) ->
        data.submit()
      done: (e, data) ->
        $.each data.result, (index, file) ->
          $scope.$apply (scope) ->
            scope.photos.push(new PropertyPhoto(file))

  $scope.done = ->
    $scope.update_feeds()

window.FeedsPropertyPhotoNewController.$inject = ['$scope', 'PropertyPhoto']

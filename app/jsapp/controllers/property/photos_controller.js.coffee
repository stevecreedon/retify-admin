window.PropertyPhotosController = ($scope, PropertyPhoto) ->

  jQuery ->
    $('#fileupload').fileupload
      dataType: 'json'
      headers: { 'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content') }
      url: "/api/properties/#{$scope.property_cached.id}/photos"
      add: (e, data) ->
        data.submit()
      done: (e, data) ->
        $.each data.result, (index, file) ->
          $scope.$apply (scope) ->
            scope.property.photos.push(new PropertyPhoto(file))
            scope.notify.success text: 'Photo was saved'

  $scope.delete = (photo) ->
    new PropertyPhoto(photo).$delete ->
      $scope.property.photos.splice($scope.property.photos.indexOf(photo), 1)
      $scope.large_photo = undefined

  $scope.show_photo = (photo) ->
    $scope.large_photo = photo

window.PropertyPhotosController.$inject = ['$scope', 'PropertyPhoto']

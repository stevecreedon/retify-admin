angular.module('lovebnb.factories.data_loader', [])
  .factory 'DataLoader', () ->
    from_meta: (name) ->
      attributes = $("meta[name='#{name}']").attr('content')
      if attributes
        JSON.parse(attributes)
      else
        null

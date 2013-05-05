angular.module('lovebnb.factories.notify', [])
  .factory 'Notify', () ->
    alert:  ( options ) ->
      opts = { type: 'error' }
      this.noty(angular.extend(opts, options))

    success: ( options ) ->
      opts = { type: 'success' }
      this.noty(angular.extend(opts, options))

    noty:   ( options ) ->
      opts =
        layout: 'topCenter'
        timeout: 5000
        type: 'success'
      noty(angular.extend(opts, options))



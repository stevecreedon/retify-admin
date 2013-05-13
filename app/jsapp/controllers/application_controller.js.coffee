window.ApplicationController = ($scope, $location, Notify, Messages, DataLoader, Site) ->
  $scope.init = ->
    $scope.notify   = Notify
    $scope.messages = Messages
    $scope.set_body_class('feeds')
    $scope.load_user()
    $scope.current_site = new Site(DataLoader.from_meta('site'))

  $scope.block = ->
    $.blockUI
      message: 'Loading ...'
      fadeIn: 100
      fadeOut: 200
      #baseZ: 2000 # uncoment if menu needed to be blocked as well
      css:
        border: 'none'
        padding: '15px'
        backgroundColor: '#000'
        '-webkit-border-radius': '10px'
        '-moz-border-radius': '10px'
        opacity: .5
        color: '#fff'
      overlayCSS:
        backgroundColor: '#000'
        opacity:         0.1
        cursor:          'wait'

  $scope.unblock = ->
    $.unblockUI()

  $scope.load_user = (user) ->
    if user
      $scope.current_user = angular.extend user
    else
      $scope.current_user = DataLoader.from_meta('current-user')


    window.location = '/session/sign_in' unless $scope.current_user
    $location.path('/account')           unless $scope.current_user.phone && $scope.current_user.name

    if $scope.current_user.password_identity && $scope.current_user.password_identity.state == 'verifying'
      $scope.notify.alert text: $scope.messages.user.verify, timeout: 10000

  $scope.set_body_class = (class_name)->
    $scope.body_class = class_name

  $scope.show_help = () ->
    $scope.notify.noty
      text: $(".btn-interactive-help").siblings(".help_container").html()
      modal: true
      timeout: false
      type: 'information'

  $scope.init()
window.ApplicationController.$inject = ['$scope', '$location', 'Notify', 'Messages', 'DataLoader', 'Site']

angular.module('lovebnb.directives.switch', [])
  .directive 'switch', () ->
    transclude: true
    restrict: 'E'
    compile: (element, attr, controller) ->
      element.html(
        "<div class='switch' ng-class='{\"off\": #{attr.value}}' ng-switch='#{attr.value}' ng-click='#{attr.value} = !#{attr.value}'>" +
          "<div ng-switch-when='true'>#{attr.off}</div>" +
          "<div ng-switch-when='false'>#{attr.on}</div>" +
          "<button class='btn'></button>" +
        "</div>"
      )

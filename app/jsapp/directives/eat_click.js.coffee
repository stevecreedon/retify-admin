angular.module('lovebnb.directives.eat_click', [])
  .directive 'eatClick', () ->
    (scope, element, attrs) ->
      $(element).click ->
        return false

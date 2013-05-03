# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require jquery
#= require angular/angular
#= require angular/angular-resource
#= require bootstrap
#= require marked
#= require jquery.ui.widget
#= require jquery.iframe-transport
#= require jquery.fileupload
#= require noty/jquery.noty
#= require noty/layouts/top_center
#= require noty/themes/default

#= require_tree ./factories
#= require_tree ./directives
#= require_tree ./controllers
#= require_tree ./views
#= require models
#= require routes
#= require_self

# App Module

window.Lovebnb = angular.module('lovebnb', [
  'lovebnb.routes',
  'lovebnb.models',
  'lovebnb.factories.model',
  'lovebnb.directives.field',
  'lovebnb.directives.eat_click'
])

// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.draggable
//= require jquery.ui.droppable
//= require jquery.ui.resizable
//= require jquery.ui.selectable
//= require jquery.ui.sortable
//= require jquery.ui.accordion
//= require jquery.ui.autocomplete
//= require jquery.ui.button
//= require jquery.ui.dialog
//= require jquery.ui.slider
//= require jquery.ui.tabs
//= require jquery.ui.datepicker
//= require jquery.ui.progressbar
//= require jquery.ui.effect.all
//= require twitter/bootstrap
//= require jquery.cookie
//= require fullcalendar.min
//= require jquery.dataTables.min
//= require excanvas
//= require jquery.flot.min
//= require jquery.flot.pie.min
//= require jquery.flot.stack
//= require jquery.flot.resize.min
//= require jquery.chosen.min
//= require jquery.uniform.min
//= require jquery.cleditor.min
//= require jquery.noty
//= require jquery.elfinder.min
//= require jquery.raty.min
//= require jquery.iphone.toggle
//= require jquery.uploadify-3.1.min
//= require jquery.gritter.min
//= require jquery.imagesloaded
//= require jquery.masonry.min
//= require jquery.knob
//= require jquery.sparkline.min
//= require jquery.namespace
//= require custom
//= require bootstrap
//= require application/content
//= require application/sidebar
//= require_self

$(document).ready(function(){

  Application.sidebar.selector = "div.sidebar-nav";
  Application.content.selector = "div#dynamic-content";

  Application.sidebar.setLinksToRemote();

  Application.sidebar.beforeContentSet(function(data){
    Application.sidebar.setActiveMenuItem(data.activeLink);
  });
});


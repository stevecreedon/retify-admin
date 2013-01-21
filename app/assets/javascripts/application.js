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
//= require jquery-extensions
//= require custom
//= require bootstrap
//= require_self

$.namespace("Application.sidebar");
$.namespace("Application.content");

$(document).ready(function(){

  Application.sidebar.setLinksToRemote();

  Application.sidebar.get().bind("sidebar.beforeContentSet", function(e, data){
    Application.sidebar.get().find("li").each(function(){ $(this).removeClass("active"); });
    data.activeLink.parent().addClass('active');
  });
});

Application.content = {
  selector: "div#dynamic-content",
  get: function(){
    return $(this.selector);
  },
  setHtml: function(html){
    this.get().html(html);
  },
};

Application.sidebar = {
  selector: "div.sidebar-nav",
  get: function(){
    return $(this.selector);
  },
  beforeContentSet: function(active, html){
    this.get().trigger("sidebar.beforeContentSet", { activeLink: active, html: html });
  },
  afterContentSet: function(active, html){
    this.get().trigger("sidebar.afterContentSet", { activeLink: active, html: html });
  },
  setLinksToRemote: function(){
    this.get().find('a').each(function(){
       var elem = $(this);
       var url =  elem.attr("href");
       elem.attr("href", "#");
       elem.attr("data-url",url);
    });

    this.get().find('a').click(function(){
       var current = $(this);
       var url = $(this).attr("data-url");
       var request = $.ajax({
         type: "GET",
         url: url,
         dataType: 'html',
       });
       request.done(function(data){
         Application.sidebar.beforeContentSet(current, data);
         Application.content.setHtml(data);
         Application.sidebar.afterContentSet(current, data);
       });
       request.fail(function(){alert("ooops something went wrong, do try again")});
    });
  },
};


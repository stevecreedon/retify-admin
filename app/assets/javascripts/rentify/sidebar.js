//= require rentify/content

$.namespace("Rentify.sidebar");

Rentify.sidebar.setActiveMenuItem = function(activeLink){
  Rentify.$sidebar.find("li").each(function(){
    $(this).removeClass("active");
   });
  activeLink.parent().addClass('active');
}

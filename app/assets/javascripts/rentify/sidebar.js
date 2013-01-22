//= require rentify/content

$.namespace("Rentify.sidebar");

Rentify.sidebar.setActiveMenuItem = function(activeLink){
  Rentify.$sidebar.find("li").each(function(){ 
    $(this).removeClass("active");
   });
  activeLink.parent().addClass('active');
}

Rentify.sidebar.setLinksToRemote = function(){
  Rentify.$sidebar.find('a').each(function(){
    var elem = $(this);
    var url =  elem.attr("href");
    elem.attr("href", "#");
    elem.attr("data-url",url);
  });

  Rentify.$sidebar.find('a').click(function(){
    var current = $(this);
    var url = $(this).attr("data-url");
    var request = $.ajax({
      type: "GET",
      url: url,
      dataType: 'html',
    });
    request.done(function(data){
      Rentify.$sidebar.trigger("sidebar.beforeContentSet", { activeLink: current, html: data });
      Rentify.content.setHtml(data);
      Rentify.$sidebar.trigger("sidebar.afterContentSet", { activeLink: current, html: data });
    });
    request.fail(function(){alert("ooops something went wrong, do try again")});
  });
}

Rentify.sidebar.beforeContentSet = function(callback) {
  this.bind("sidebar.beforeContentSet", callback);
}

Rentify.sidebar.afterContentSet = function(callback) {
  this.bind("sidebar.afterContentSet", callback);
}

Rentify.sidebar.bind = function(eventName, callback){
  var c = callback;
  Rentify.$sidebar.bind(eventName, function(e, data){
    c(data);
  });
}

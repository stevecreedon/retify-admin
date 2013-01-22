//= require application/content

$.namespace("Application.sidebar");

Application.sidebar.setActiveMenuItem = function(activeLink){
  Application.$sidebar.find("li").each(function(){ 
    $(this).removeClass("active");
   });
  activeLink.parent().addClass('active');
}

Application.sidebar.setLinksToRemote = function(){
  Application.$sidebar.find('a').each(function(){
     var elem = $(this);
     var url =  elem.attr("href");
     elem.attr("href", "#");
     elem.attr("data-url",url);
  });

  Application.$sidebar.find('a').click(function(){
     var current = $(this);
     var url = $(this).attr("data-url");
     var request = $.ajax({
       type: "GET",
       url: url,
       dataType: 'html',
     });
     request.done(function(data){
       Application.sidebar.triggerBeforeContentSet(current, data);
       Application.content.setHtml(data);
       Application.sidebar.triggerAfterContentSet(current, data);
     });
     request.fail(function(){alert("ooops something went wrong, do try again")});
  });
}

Application.sidebar.beforeContentSet = function(callback) {
  this.bind("sidebar.beforeContentSet", callback);
}

Application.sidebar.afterContentSet = function(callback) {
  this.bind("sidebar.afterContentSet", callback);
}

Application.sidebar.bind = function(eventName, callback){
  var c = callback;
  Application.$sidebar.bind(eventName, function(e, data){
    c(data);
  });
}

Application.sidebar.triggerBeforeContentSet = function(active, html){
  Application.$sidebar.trigger("sidebar.beforeContentSet", { activeLink: active, html: html });
}

Application.sidebar.triggerAfterContentSet = function(active, html){
  Application.$sidebar.trigger("sidebar.afterContentSet", { activeLink: active, html: html });
}


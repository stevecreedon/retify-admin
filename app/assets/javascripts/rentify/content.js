$.namespace("Rentify.content");

Rentify.content.setHtml = function(html){
  Rentify.$content.trigger("content.beforeContentSet", { html: html });
  Rentify.$content.html(html);
  Rentify.$content.trigger("content.afterContentSet", { html: html });
}

Rentify.content.addListenersForRemoteForms = function() {
  Rentify.$content.find("form[data-remote]")
    .bind('ajax:before', function(){ })
    .bind('ajax:complete', function(){ })
    .bind('ajax:success', function(event, data, status, xhr){
      Rentify.content.setHtml(data);
    })
    .bind('ajax:error', function(xhr, status, error){
      alert("ooops something went wrong, do try again")
    })
}

Rentify.content.addListenersForRemoteLinks = function(scope) {
  $(scope).find('a[data-remote]').each(function(){
    var elem = $(this);
    var url =  elem.attr("href");
    elem.attr("href", "#");
    elem.attr("data-url",url);
  });

  $(scope).find('a[data-remote]').click(function(){
    Rentify.content.$currentLink = $(this);
    var url = $(this).attr("data-url");
    var request = $.ajax({
      type: "GET",
      url: url,
      dataType: 'html',
    });
    request.done(function(data){
      Rentify.content.setHtml(data);
    });
    request.fail(function(){
      alert("ooops something went wrong, do try again");
    });
    return false;
  });
}

Rentify.content.beforeContentSet = function(callback) {
  this.bind("content.beforeContentSet", callback);
}

Rentify.content.afterContentSet = function(callback) {
  this.bind("content.afterContentSet", callback);
}

Rentify.content.bind = function(eventName, callback){
  var c = callback;
  $(document).bind(eventName, function(e, data){
    c(e, data);
  });
}

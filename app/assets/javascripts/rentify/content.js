$.namespace("Rentify.content");

Rentify.content.setHtml = function(html){
  Rentify.$content.trigger("content.beforeContentSet", { html: html });
  Rentify.$content.html(html);
  Rentify.$content.trigger("content.afterContentSet", { html: html });
}

Rentify.content.addListenersForRemoteForms = function(scope) {
  scope.find("form[data-ajax]").submit( function(e) {
    e.stopPropagation();
    var request = $.ajax( {
      type: "POST",
      url: $(this).attr('action'),
      data: $(this).serialize(),
    });
    request.done(function( response ) {
      Rentify.content.setHtml( response );
    });
    request.fail(function(xhr, status, error){
      alert("ooops something went wrong, do try again");
    });
    return false;
  });
}

Rentify.content.addListenersForRemoteLinks = function(scope) {
  $(scope).find('a[data-ajax]').each(function(){
    var elem = $(this);
    if(!elem.data('url')){
      var url =  elem.attr("href");
      elem.attr("href", "#");
      elem.data("url",url);
      elem.click(function(){
        Rentify.content.$currentLink = $(this);
        var url = $(this).data("url");
        var type = "GET";
        if($(this).data('method')){
          type = $(this).data('method');
        };
        var request = $.ajax({
          type: type,
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
    };
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

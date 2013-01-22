$.namespace("Rentify.content");

Rentify.content.setHtml = function(html){
  Rentify.$content.html(html);
}

Rentify.content.addListenersForRemoteForms = function() {
  Rentify.$content.find("form[data-remote]")
    .bind('ajax:before', function(){ })
    .bind('ajax:complete', function(){ })
    .bind('ajax:success', function(event, data, status, xhr){
      Rentify.$content.html(data);
    })
    .bind('ajax:error', function(xhr, status, error){
      alert("ooops something went wrong, do try again")
    })
}



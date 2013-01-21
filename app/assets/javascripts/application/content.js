$.namespace("Application.content");

if(Application.content.selector == undefined){
  Application.content.selector = "div#dynamic-content";
}

Application.content.get = function(){
  return $(this.selector);
}

Application.content.setHtml = function(html){
  this.get().html(html);
}



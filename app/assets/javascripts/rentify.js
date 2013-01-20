jQuery.namespace = function() {
    var a=arguments, o=null, i, j, d;
    for (i=0; i<a.length; i=i+1) {
        d=a[i].split(".");
        o=window;
        for (j=0; j<d.length; j=j+1) {
            o[d[j]]=o[d[j]] || {};
            o=o[d[j]];
        }
    }
    return o;
};

$.namespace("Rentify.sidebar");
$.namespace("Rentify.content");


$(document).ready(function(){

  $("div.sidebar-nav a").each(function(){
     var url =  $(this).attr("href");
     $(this).attr("href", "#");
     $(this).attr("data-url",url);     
  });

  $("div.sidebar-nav a").click(function(){
     var url = $(this).attr("data-url");
     var request = $.ajax({
	type: "GET",     
     	url: url,
	dataType: 'html', 
     });
     request.done(function(data){Rentify.content.set(data)});
     request.fail(function(){alert("ooops something went wrong, do try again")});
  })
})

Rentify.content.set = function(html){
  $("div#dynamic-content").html(html);   	
}



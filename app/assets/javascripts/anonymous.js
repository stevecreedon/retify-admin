$(document).ready(function(){
  $("div.flash-alert").each(function(){
  	noty({text: $(this).text(), type: 'error'});
  });

  $("div.flash-notice").each(function(){
  	noty({text: $(this).text(), type: 'success'});
  });
});

$(document).ready(function(){ 

	$(".btn-help").click(function(){
	     var control = $(this).siblings("input");
	     var helpId = "#help_" + control.attr("id");
	     var helpContainer = $(helpId); 
	     var helpText = new Array();

	     helpText.push("<h1 style='text-align: left;'>help with " + control.attr("id").replace(/_/," ") + "</h1>");

	     $.each(["what", "why", "example"], function(index,value){
	       helpText.push("<h2 style='text-align: left;'>" + (index + 1) + ". " + value + ":</h2><div style='text-align: left;' >" + helpContainer.find("." + value).html() + "</div>");
	     });

	     noty({text: helpText.join(""), modal: true, timeout: false, notyTemplate: '<div style="text-align: left;" class="noty_message"><span class="noty_text"></span><div class="noty_close"></div></div>'});
	      
	});

});


/* Foundation v2.2 http://foundation.zurb.com */
jQuery(document).ready(function ($) {
	
	$("div.clickable").click(function() {
  	window.location = $(this).attr("url");
  	return false;
  });

	$('#content ul').addClass('square');
});
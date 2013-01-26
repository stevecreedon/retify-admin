// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require_self

$(function () {
  var $container = $('.masonry-gallery');

  var gutter = 6;
  var min_width = 180;
  $container.imagesLoaded( function(){
    $container.masonry({
      itemSelector : '.masonry-thumb',
      gutterWidth: gutter,
      isAnimated: true,
      columnWidth: function( containerWidth ) {
        var num_of_boxes = (containerWidth/min_width | 0);

        var box_width = (((containerWidth - (num_of_boxes-1)*gutter)/num_of_boxes) | 0) ;

        if (containerWidth < min_width) {
            box_width = containerWidth;
        }

        $('.masonry-thumb').width(box_width);

        return box_width;
      }
    });
  });

  $(".progress").progressbar({ value: 0 });

  $('#fileupload').fileupload({
    dataType: 'json',
    done: function (e, data) {
      $.each(data.result, function (index, file) {
        html = '<div class="masonry-thumb">' +
                 '<a data-ajax="true" style="background:url(' + file.url + ')" href="' + file.show_url + '">' +
                    '<img class="grayscale" src="' + file.thumbnail_url + '">' +
                 '</a>' +
               '</div>';

        $('#gallery').append(html);
      });
      $('.masonry-gallery').masonry( 'reload' );
      $(".masonry-gallery").trigger("resize");
      $( ".progress" ).progressbar( "value", 0 );
      Rentify.content.addListenersForRemoteLinks(Rentify.$content);
    },
    fail: function() {
      alert("ooops something went wrong, do try again");
    },
    progressall: function (e, data) {
      var progress = parseInt(data.loaded / data.total * 100, 10);
      $( ".progress" ).progressbar( "value", progress );
    }
  });
});

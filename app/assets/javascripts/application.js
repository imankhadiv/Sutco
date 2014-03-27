// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-datepicker
//= require bootstrap-timepicker
//= require jquery_nested_form
//= require bootstrap
//= require application_jquery

//= require_tree .
$(function (){
	$('#workshop_date').datepicker();
	$('#workshop_time').timepicker();
	$('#social_date').datepicker();
	$('#social_time').timepicker();
	$('#training_date').datepicker();
	$('#training_time').timepicker();
	$('#show_date').datepicker();
	$('#show_show_dates_date').datepicker();

});

$(function remove_fields(link) {
  $(link).previous("input[type=hidden]").value = "1";
  $(link).up(".fields").hide();
});

$(function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).up().insert({
    before: content.replace(regexp, new_id)
  });
});

$(function(){
    //get the background-color for each tile and apply it as background color for the cooresponding screen
    $('.tile').each(function(){
        var $this= $(this),
            page = $this.data('page-name'),
            bgcolor = $this.css('background-color'),
            textColor = $this.css('color');
            
            //if the tile rotates, we'll use the colors of the front face
            if($this.hasClass('rotate3d')) {
              frontface = $this.find('.front');
              bgcolor = frontface.css('background-color');
              textColor = frontface.css('color');
            }

            //if the tile has an image and a caption, we'll use the caption styles
            if($this.hasClass('fig-tile')) {
              caption = $this.find('figcaption');
              bgcolor = caption.css('background-color');
              textColor = caption.css('color');
            }

        $this.on('click',function(){
          $('.'+page).css({'background-color': bgcolor, 'color': textColor})
                     .find('.close-button').css({'background-color': textColor, 'color': bgcolor});
        });
    });

	  function showDashBoard(){
      for(var i = 1; i <= 3; i++) {
        $('.col'+i).each(function(){
            $(this).addClass('fadeInForward-'+i).removeClass('fadeOutback');
        });
      }
    }

    function fadeDashBoard(){
      for(var i = 1; i <= 3; i++) {
        $('.col'+i).addClass('fadeOutback').removeClass('fadeInForward-'+i);
      }
    }
  
    
  //listen for when a tile is clicked
  //retrieve the type of page it opens from its data attribute
  //based on the type of page, add corresponding class to page and fade the dashboard
  $('.tile').each(function(){
    var $this= $(this),
        pageType = $this.data('page-type'),
        page = $this.data('page-name');
        
    $this.on('click',function(){
      if(pageType === "s-page"){
          fadeDashBoard();
          $('.'+page).addClass('slidePageInFromLeft').removeClass('slidePageBackLeft');
        }
        else{
          $('.'+page).addClass('openpage');
          fadeDashBoard();
        }
    });
  });

  //when a close button is clicked:
  //close the page
  //wait till the page is closed and fade dashboard back in
  $('.r-close-button').click(function(){
      $(this).parent().addClass('slidePageLeft')
          .one('webkitAnimationEnd oanimationend msAnimationEnd animationend', function(e) {
                $(this).removeClass('slidePageLeft').removeClass('openpage');
              });
      showDashBoard();
  });
  $('.s-close-button').click(function(){
      $(this).parent().removeClass('slidePageInFromLeft').addClass('slidePageBackLeft');
      showDashBoard();
  });

});
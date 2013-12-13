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
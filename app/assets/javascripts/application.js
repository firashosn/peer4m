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
//= require_tree
//= require bootstrap
//= require bootstrap-datepicker


// Ensuring the bg images are the height on the viewport on page load
$(document).ready(function() {
	WinHeight = $(window).height()
$('.bg.mac, .bg.student').css('height', WinHeight);
	
});

// Temp popover on front-end login modal that indicates we are in beta.
$(document).ready(function() {
	
	$("[data-toggle=popover]").popover();
	
});

// Tooltip with text to describe icons
$(document).ready(function() {
	$('.tb-btn-space').tooltip();
});

// Datepicker
function add_datepicker() {
	$('[data-behaviour~=datepicker]').datepicker({ format: 'dd/mm/yyyy'});
}

// Active Link

// $(document).ready(function() {
// 	$('.navbar-default .navbar-nav.internal-nav > li > a').click(function(){
//     $('.navbar-default .navbar-nav.internal-nav > li > a').removeClass("blue-active");
// 	$(this).addClass("blue-active");
// 	})
// });












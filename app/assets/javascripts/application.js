// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require tether
//= require bootstrap
//= require jquery_ujs
//= require turbolinks
//= mCustomScrollbar
//= require cookie
//= require_tree .


$(document).on('turbolinks:load', function() {
    console.log("App.js exec")
});

function closeSlider() {
    document.getElementById("slider").style.width = "0";
}

function openSlider() {
    document.getElementById("slider").style.width = "100%";
}


function LoadSliderWith(url,data){
        
}
// END OF Global slider 

function SwitchCookie(name) {
  if ($.cookie(name) == "true") {
    $.cookie(name,"false")
    return false
  } else {
    $.cookie(name,"true")
    return true
  }
}
//= require jquery
//= require tether
//= require bootstrap
//= require jquery_ujs
//= require turbolinks
//= require loader
//= mCustomScrollbar
//= require cookie
//= require versions
//= require colorpicker
//= require d3
//= require_tree .


$(document).on('turbolinks:load', function() {
    console.log("App.js exec")
});

function SwitchCookie(name) {
  if ($.cookie(name) == "true") {
    $.cookie(name,"false")
    return false
  } else {
    $.cookie(name,"true")
    return true
  }
}

$(document).on('turbolinks:load', function() {
  var wrapper         = $(".custom-fields-body"); 
  var add_button      = $(".btn-add-custom"); 
  var del_button      = $(".btn-del-custom"); 
  
  $(add_button).click(function(e){ //on add input button click
      e.preventDefault();
      $(wrapper).append('<tr class="custom-node"><td><input class="form-control name" type="text"></input></td><td><input class="form-control value" type="text"></input></td><td><button class="btn btn-sm btn-danger btn-del-custom">-</button></td></tr>'); //add input box
  });
  del_button.on("click", function(e){ //user click on remove text
      e.preventDefault(); $(this).parent('td').parent('tr').remove();
  })
  
  $(function () {
    $('[data-toggle="tooltip"]').tooltip()
  })
}
);

function getFormData(){
    var wrapper = $(".custom-fields-body");
    var json_holder = $(".json_holder")
    ArrayArg = new Array()
    wrapper.find(".custom-node").each(function(index) {
      var jsonArg = new Object();
          jsonArg.name = $(this).find(".name").val()
          jsonArg.val = $(this).find(".value").val();
      ArrayArg.push(jsonArg);
    });
    var json = JSON.stringify(ArrayArg);
    console.log(json);
    json_holder.val(json);
}
/* global $*/
function LoadModalWith(url,data){
   $.ajax({
      method: "GET",
      url: url,
      data: data,
      beforeSend: function( xhr ) {
    
      }
    })
    .done(function(html) {
      $(".modal-body").empty();
      $(".modal-body").append(html);
      $('#globalModal').modal('show')
    })
    .fail(function(e) {
      console.log( "Error in loading modal" );
    })
    .always(function() {
    
    });     
}

function closeModal(){
  $('#globalModal').modal('hide');
}

function LoadModalWithImg(src,modal){
  $(".modal-body").empty();
  $(".modal-body").append("<div class=\"text-xs-center\"><img class=\"img-fluid mx-auto\" src=\""+src+"\" /></div>");
  $(modal).modal('show')
}
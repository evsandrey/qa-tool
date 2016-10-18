/* global $*/

function closeSlider() {
    document.getElementById("slider").style.width = "0";
}

function openSlider() {
    document.getElementById("slider").style.width = "100%";
}


function LoadSliderWith(url,data){
   $.ajax({
      method: "GET",
      url: url,
      data: data,
      beforeSend: function( xhr ) {
        //Start loader
        $(".slider-loader").show();
        $(".slider-content").html("");
        openSlider();
      }
    })
    .done(function(html) {
      $(".slider-content").append(html);
      $(".slider-loader").toggle();
    })
    .fail(function(e) {
      console.log( "Error in loading slider" );
      console.log(e);
      closeSlider();
    })
    .always(function() {
      //Close loader
      $(".slider-loader").hide();
    });     
}
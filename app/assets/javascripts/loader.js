/* global $*/

SliderLinkLoaded="";
SliderDataLoaded="";




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
        SliderLinkLoaded=url;
        SliderDataLoaded=data;
        //Start loader
        $(".slider-loader").show();
        $(".slider-content").empty();
        openSlider();
      }
    })
    .done(function(html) {
      $(".slider-content").append(html);
      var arr = document.getElementsByClassName("slider-content")[0].getElementsByTagName('script')
      console.log(arr);
      for (var n = 0; n < arr.length; n++)
      {
        eval(arr[n].innerHTML);
      }
      $(".slider-loader").hide();
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


function ReloadSlider() {
  LoadSliderWith(SliderLinkLoaded,SliderDataLoaded);
}

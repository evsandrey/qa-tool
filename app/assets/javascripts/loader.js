/* global $*/

SliderLinkLoaded="";
SliderDataLoaded="";




function closeSlider() {
    document.getElementsByClassName("closebtn")[0].style['position'] = "absolute";
    document.getElementById("slider").style.width = "0";
}

function openSlider() {
    document.getElementById("slider").style.width = "100%";
    document.getElementsByClassName("closebtn")[0].style['position'] = "fixed";
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
      // var arr = document.getElementsByClassName("slider-content")[0].getElementsByTagName('script')
      // for (var n = 0; n < arr.length; n++)
      // {
      //   // eval(arr[n].innerHTML);
      // }
      // $(".slider-loader").hide();
    })
    .fail(function(xhr,err) {
      console.log( "Error in loading slider" );
      console.log(err);
      $(".slider-content").append(xhr.responseText);
      //closeSlider();
    })
    .always(function() {
      //Close loader
      $(".slider-loader").hide();
    });     
}


function ReloadSlider() {
  LoadSliderWith(SliderLinkLoaded,SliderDataLoaded);
}

/* global $*/

$(document).on('turbolinks:load', function() {
    console.log("Versions.js exec");
    $(".report-icon").on("click", function(e){ 
      e.preventDefault(); 
      LoadSliderWith("/reports/"+this.id,{});
  })
});

function updateReportIcon(msg) {
  $("#cell-"+msg['id']['$oid']).empty();
  $(msg['message']).appendTo($("#cell-"+msg['id']['$oid']));
  $("#cell-"+msg['id']['$oid']).find( "span" ).on("click", function(e){ 
      e.preventDefault(); 
      LoadSliderWith("/reports/"+this.id,{});
  })
}
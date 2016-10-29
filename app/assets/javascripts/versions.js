/* global $*/

$(document).on('turbolinks:load', function() {
    console.log("Versions.js exec");
    $(".report-icon").on("click", function(e){ 
      e.preventDefault(); 
      LoadSliderWith("/reports/"+this.id,{});
  })
});

function updateReportIcon(msg) {
  console.log(msg);
  var report_id= msg['id']['$oid'];
  var suite_id = msg['suite']['$oid'];
  var build_id = msg['build']['$oid'];
  var cell = findByCoord("build-"+build_id,"suite-"+suite_id,"big-mama")
  
  $("#cell-"+msg['id']['$oid']).empty();
  $(msg['message']).appendTo($("#cell-"+msg['id']['$oid']));
  $("#cell-"+msg['id']['$oid']).find( "span" ).on("click", function(e){ 
      e.preventDefault(); 
      LoadSliderWith("/reports/"+this.id,{});
  })
}


function findByCoord(colId,rowId,tableId) {
  var table = $('#'+tableId);
  var colIndex = table.find("th#"+colId).cellIndex;
  var rowIndex = table.find("tr#"+rowId).rowIndex;
  return table.find('tr')[rowIndex].find('td')[colIndex]
};
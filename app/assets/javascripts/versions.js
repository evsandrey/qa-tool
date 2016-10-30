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
  var cell = findByCoord("big-mama","build-"+build_id,"suite-"+suite_id)
  cell.empty();
  $(msg['message']).appendTo(cell);
  cell.find( "div" ).on("click", function(e){ 
      e.preventDefault(); 
      LoadSliderWith("/reports/"+this.id,{});
  })
}

function addBuild(msg) {
  var build_id = "build-"+msg['id']['$oid'];
  var build_name = msg['name'];
  addColumn('big-mama',build_id,build_name)
}


function findByCoord(tableId,colId,rowId) {
  var table = $('#'+tableId);
  var colIndex = table.find("th#"+colId).index();
  var rowIndex = table.find("tr#"+rowId).index();
  return $($(table.find('tr')[rowIndex+1]).find('td')[colIndex])
};




function addColumn(tableId,colId,colHead) {
  var c = $("#"+tableId+" thead th").length;
  $("#"+tableId+" thead tr").append("<th id='"+colId+"'>"+colHead+"</th>");
  $("#"+tableId+" tr:gt(0)").append("<td></td>");
}
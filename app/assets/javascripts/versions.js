/* global $*/

$(document).on('turbolinks:load', function() {
    console.log("Versions.js exec");
    $(".report-icon").on("click", function(e){ 
      e.preventDefault(); 
      LoadSliderWith("/reports/"+this.id,{});
    });
    
    // $(".build-head").on("click", function(e){ 
    //   e.preventDefault(); 
    //   LoadSliderWith(window.location.href+"/builds/"+this.id.replace("build-",""),{});
    // });
    
});

function updateReportIcon(msg) {
  console.log(msg);
  var report_id= msg['id']['$oid'];
  var test_case_id = msg['test_case']['$oid'];
  var build_id = msg['build']['$oid'];
  var cell = findByCoord("big-mama","build-"+build_id,"test_case-"+test_case_id)
  cell.empty();
  $(msg['message']).appendTo(cell);
  cell.find( ".report-icon" ).on("click", function(e){ 
      e.preventDefault(); 
      LoadSliderWith("/reports/"+this.id,{});
  })
}

function addBuild(msg) {
  var build_id = "build-"+msg['id']['$oid'];
  var build_name = msg['name'];
  addColumn('big-mama',build_id,build_name)
}

function addtest_case(msg) {
  var test_case_id = "test_case-"+msg['id']['$oid'];
  var test_case_name = msg['name'];
  addRow('big-mama',test_case_id,test_case_name)
} 


function findByCoord(tableId,colId,rowId) {
  console.log(tableId,colId,rowId)
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

function addRow(tableId,rowId,rowName) {
  var c = $("#"+tableId+" thead th").length;
  var row = $("<tr id='"+rowId+"'></tr>");
  row.append("<td>"+rowName+"</td>");
  for (var i = 0; i < c-1; i++) { 
    row.append("<td></td>")  
  }
  var c = $("#"+tableId+" tbody").append(row);
}

function enlargeImage(smSrc, lgSrc) {
    document.getElementById('largeImg').src = smSrc;
    showLargeImagePanel();
    unselectAll();
    setTimeout(function() {
        document.getElementById('largeImg').src = lgSrc;
    }, 1)
}
function showLargeImagePanel() {
    document.getElementById('largeImgPanel').style.display = 'block';
}
function unselectAll() {
    if(document.selection)
        document.selection.empty();
    if(window.getSelection)
        window.getSelection().removeAllRanges();
}
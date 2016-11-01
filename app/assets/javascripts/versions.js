/* global $*/

$(document).on('turbolinks:load', function() {
    console.log("Versions.js exec");
    $(".report-icon").on("click", function(e){ 
      e.preventDefault(); 
      LoadSliderWith("/reports/"+this.id,{});
    });
        console.log("Stacked bar started");
            stackedbar = new D3StackedBar({ 
            container: "#stackedbar",
            margin: {top: 20, left: 50, bottom: 50, right: 20},
            spacing: 0.5,
            dataUrl: null,
            data: [ 
                    { key: "category 1", values: [ { x: "FY2008", y: 10 }, { x: "FY2009", y: 20 }, { x: "FY2010", y: 30 }, { x: "FY2011", y: 5 }, { x: "FY2012", y: 15 } ]}, 
                    { key: "category 2", values: [ { x: "FY2008", y: 20 }, { x: "FY2009", y: -40 }, { x: "FY2010", y: 20 }, { x: "FY2011", y: 5 }, { x: "FY2012", y: 10 } ]}, 
                    { key: "category 3", values: [ { x: "FY2008", y: -10 }, { x: "FY2009", y: 10 }, { x: "FY2010", y: 10 }, { x: "FY2011", y: -10 }, { x: "FY2012", y: 10 } ]}, 
                  ],
            resizable: true,
            showLegend: true,
            showTooltip: true,
            showRuler: true,
            showHorizontalGrid: true,
            displayTable: true,
            yFormat: function(d) { return d; },
            colors: ['rgb(166,206,227)','rgb(31,120,180)','rgb(178,223,138)','rgb(51,160,44)','rgb(251,154,153)','rgb(227,26,28)','rgb(253,191,111)','rgb(255,127,0)','rgb(202,178,214)','rgb(106,61,154)','rgb(255,255,153)','rgb(177,89,40)'],
            xTickSize: function(base) { return 10; },
            yTickSize: function(base) { return 10; },
            xTicks: 5,
            yTicks: 5,
            xTickPadding: 5,
            yTickPadding: 5,
            yAxisTranslate: function(base) { return "translate(0,0)"; },
            xAxisTranslate: function(base) { return "translate(0,"+base.height+")"; },
            xTickFormat: function(d) { return d; },
            yTickFormat: function(d) { return d; },
            tooltipText: function(d, element) { return "<p>Tooltip<br />x: "+d.x+"<br />y:"+d.y+"<p>"; }
          });
          stackedbar.show();
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

function addSuite(msg) {
  var suite_id = "suite-"+msg['id']['$oid'];
  var suite_name = msg['name'];
  addRow('big-mama',suite_id,suite_name)
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

function addRow(tableId,rowId,rowName) {
  var c = $("#"+tableId+" thead th").length;
  var row = $("<tr id='"+rowId+"'></tr>");
  row.append("<td>"+rowName+"</td>");
  for (var i = 0; i < c-1; i++) { 
    row.append("<td></td>")  
  }
  var c = $("#"+tableId+" tbody").append(row);
}
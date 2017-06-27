<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>lagoon's dashboard</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/resources/css/gridstack.css"/>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.0/jquery-ui.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/3.5.0/lodash.min.js"></script>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>

<!-- https://cdnjs.com/libraries/gridstack.js -->
<script type="text/javascript" src="/resources/js/gridstack.js"></script>
<script type="text/javascript" src="/resources/js/gridstack.jQueryUI.js"></script>

<script type="text/javascript" src="/resources/js/tiscreen.common.js"></script>
<script type="text/javascript" src="/resources/js/tiscreen.component.js"></script>

<link rel="stylesheet" type="text/css" href="/resources/css/tiscreen.dashboard.css"/>

<script type="text/javascript">

var tiComponentItems = new Object(); 

$(function () {
  
  var options = {
      float: false,
      cellHeight: 80,
      verticalMargin: 5,
      handleClass : "grid-stack-item-content-header",
      animate : true
  };
  
  var exNode = {
      "x" : 0, 
      "y" : 0, 
      "width" : 4, 
      "height" : 3, 
      "autoPosition" : true, 
      "minWidth" : 3, 
      "maxWidth" : 8, 
      "minHeight" : 2, 
      "maxHeight" : 8 
  };
  
  var initialize = function() {
    
    $(".grid-stack").gridstack(options);
    this.grid = $('.grid-stack').data('gridstack');
    
    $("#add-new-widget").on("click", function() {
      addTiComponent(exNode);
    });
    $("#add-new-widget-many").on("click", function() {
      for (var iCnt = 0; iCnt < 20; iCnt++) {
        addTiComponent(exNode);
      }
    });
    $("#remove-all-widget").on("click", function() {
      grid.removeAll();
    });
    $("#save").on("click", function() {
      alert("저장완료~!");
      var nodes = grid.grid.nodes;
      var saveNodes = new Array();
      for (var iCnt = 0; iCnt < nodes.length; iCnt++) {
        var node = nodes[iCnt];
        delete node["el"];
        delete node["_grid"];
        node["autoPosition"] = false;
        saveNodes.push(node);
      }
      tiCommon.setLocalStorage("tiscreen_data", JSON.stringify(saveNodes));
    });
    $("#load").on("click", function() {
      var jsonNodes = tiCommon.getLocalStorage("tiscreen_data");
      if (jsonNodes) {
        grid.removeAll();
        var nodes = JSON.parse(jsonNodes);
        for (var iCnt = 0; iCnt < nodes.length; iCnt++) {
          addTiComponent(nodes[iCnt]);
        }
      }
    });
    
  }
  
  var numTiComponent = 0;
  var addTiComponent = function(node) {
    var nodeId = "node_" + numTiComponent;
    var tiComponentId = "component_" + numTiComponent;
    var tiComponent = "";
    tiComponent += "<div>";
    tiComponent += "  <div class='grid-stack-item-content' id=" + tiComponentId + ">";
    tiComponent += "  </div>";
    tiComponent += "</div>";
    
    grid.addWidget(
        $.parseHTML(tiComponent), 
        node.x, 
        node.y, 
        node.width, 
        node.height,
        node.autoPosition,
        node.minWidth,
        node.maxWidth,
        node.minHeight,
        node.maxHeight,
        nodeId
        );
    
    $("#" + tiComponentId).load("/load.do", {"tiComponentId" : tiComponentId, "numTiComponent" : numTiComponent, "name": "example", "title" : "Test Component(" + numTiComponent + ")...by.lagoon"});

    numTiComponent++;
  }
  
  initialize();
  
});
</script>

</head>
<body>
  <div class="header">
    <div class="inner">
      <h1>TiController</h1>
      <div class="notice"><dl><dt>공지사항</dt><dd><span>안녕하세요. TiController에 오신 것을 환영합니다. TiController는 신개념 클라우드 서비스 제품입니다.</span></dd></dl></div>
      <div class="current_time"></div>
      <div class="util"></div>
    </div>
  </div>
  <div>
    <div>
      <a class="btn btn-default" id="add-new-widget" href="#">Add TiComponent</a>
      <a class="btn btn-default" id="add-new-widget-many" href="#">Add TiComponent Many</a>
      <a class="btn btn-default" id="remove-all-widget" href="#">Remove All</a>
      <a class="btn btn-default" id="save" href="#">Save</a>
      <a class="btn btn-default" id="load" href="#">load</a>
    </div>
     <br/>
    <div class="grid-stack">
    </div>
  </div>
</body>
</html>
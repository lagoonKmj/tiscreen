<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>lagoon's dashboard</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/resources/css/gridstack.css"/>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.0/jquery-ui.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/3.5.0/lodash.min.js"></script>
<script type="text/javascript" src="/resources/js/gridstack.js"></script>
<script type="text/javascript" src="/resources/js/gridstack.jQueryUI.js"></script>
<script type="text/javascript" src="/resources/js/tiscreen.common.js"></script>
<script type="text/javascript" src="/resources/js/tiscreen.dashboard.js"></script>


<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>

<style type="text/css">
  .grid-stack {
    background: lightgoldenrodyellow;
  }

  .grid-stack-item-content {
    color: #2c3e50;
    text-align: center;
    background-color: #18bc9c;
  }
</style>
    
<script type="text/javascript">

var componentItems = new Object(); 

$(function () {
  
  var options = {
      float: false,
      cell_height: 80,
      vertical_margin: 10
  };
  
  var initialize = function() {
    $(".grid-stack").gridstack(options);
    this.grid = $('.grid-stack').data('gridstack');
    
    $("#add-new-widget").on("click", function() {
      addComponent();
    });
    $("#add-new-widget-many").on("click", function() {
      for (var iCnt = 0; iCnt < 20; iCnt++) {
        addComponent();
      }
    });
    $("#remove-all-widget").on("click", function() {
      this.grid.removeAll();
    });
    
  }
  
  var numComponent = 0;
  var addComponent = function() {
    var node = { x: 0, y: 0, width: 3, height: 3 };
    var divId = "container_" + numComponent;
    this.grid.addWidget($("<div><div class='grid-stack-item-content' id=" + divId + " style='height: 100%; max-width: 100%; margin: 0 auto'/><div/>"), node.x, node.y, node.width, node.height);
    
    $("#" + divId).load("/load.do", {"divId" : divId, "name": "example"});
//     var component_title = cmpnInfo.component_title.replace(/([\S]+)$/,"<span>$1</span>");
//     $("<div id='" + cntnId + "'></div>")
//       .prependTo("#droppable_pannel_" + pannelNo)
//       .addClass("component_container")
//       .append("<div id='" + cntnHandler + "' class='component_handler'><p class='tit'>" + component_title + "</p></div>")
//       .append("<div id='" + cntnContent + "' class='contents'>Loading...</div>")
//       .find(".component_handler")
//         .append("<p class='lbg'></p>")
//         .append("<p class='close'></p>")
//         .append("<p class='rbg'></p>")
//         .end()
//       .find(".contents")
//         .load("../component/load.do", $.extend({container_id : cntnId}, cmpnInfo));
    
    
//     drawChart(divId);
    numComponent++;
  }
  
  initialize();
  
});
</script>
    
</head>
<body>
  <div>
    <h1>lagoon's dashboard</h1>
    <div>
      <a class="btn btn-default" id="add-new-widget" href="#">Add Widget</a>
      <a class="btn btn-default" id="add-new-widget-many" href="#">Add Widget Many</a>
      <a class="btn btn-default" id="remove-all-widget" href="#">Remove All</a>
    </div>
     <br/>
    <div class="grid-stack">
    </div>
  </div>
</body>
</html>
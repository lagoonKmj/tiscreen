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
      cell_height: 80,
      vertical_margin: 5,
      handleClass : "grid-stack-item-content-header"
  };
  
  var initialize = function() {
    
    $(".grid-stack").gridstack(options);
    this.grid = $('.grid-stack').data('gridstack');
    
    $("#add-new-widget").on("click", function() {
      addTiComponent();
    });
    $("#add-new-widget-many").on("click", function() {
      for (var iCnt = 0; iCnt < 20; iCnt++) {
        addTiComponent();
      }
    });
    $("#remove-all-widget").on("click", function() {
      this.grid.removeAll();
    });
    
  }
  
  var numTiComponent = 0;
  var addTiComponent = function() {
    var node = { x: 0, y: 0, width: 4, height: 2 };
    var tiComponentId = "component_" + numTiComponent;
    var tiComponent = "";
    tiComponent += "<div>";
    tiComponent += "  <div class='grid-stack-item-content' id=" + tiComponentId + ">";
    tiComponent += "    <div class='grid-stack-item-content-header'>";
    tiComponent += "      <h2>조직 현황</h2>";
    tiComponent += "      <ul class=''><li><button type='button' onClick=''>설정</button></li><li><button type='button' onClick=''>삭제</button></li></ul>";
    tiComponent += "    <div/>";
    tiComponent += "  <div/>";
    tiComponent += "<div/>";
    this.grid.addWidget(tiComponent, node.x, node.y, node.width, node.height);
    
    $("#" + tiComponentId  + " .container").load("/load.do", {"tiComponentId" : tiComponentId, "numTiComponent" : numTiComponent, "name": "example"});

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
    </div>
     <br/>
    <div class="grid-stack">
    </div>
  </div>
</body>
</html>
<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>lagoon's dashboard</title>

<link rel="stylesheet" type="text/css" href="/resources/css/gridstack.css"/>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.0/jquery-ui.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/3.5.0/lodash.min.js"></script>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/heatmap.js"></script>
<script src="https://code.highcharts.com/highcharts-more.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>

<!-- https://cdnjs.com/libraries/gridstack.js -->
<script type="text/javascript" src="/resources/js/gridstack.js"></script>
<script type="text/javascript" src="/resources/js/gridstack.jQueryUI.js"></script>

<script type="text/javascript" src="/resources/js/tiscreen.common.js"></script>
<script type="text/javascript" src="/resources/js/tiscreen.component.js"></script>

<link rel="stylesheet" type="text/css" href="/resources/css/tiscreen/tiscreen.dashboard.css"/>

<script type="text/javascript" src="/resources/js/tiscreen/tiscreen.ui.js"></script>
<script type="text/javascript" src="/resources/js/tiscreen/tiscreen.icon.js"></script>


<script type="text/javascript">

var tiComponentItems = new Object(); 
var tiScreenType = 0; // 0 : gridstack dashboard, 1 : previous dashboard   

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
  
  var tiComp = [ "ti.bar", "ti.grid", "ti.hitmap", "ti.line", "ti.pie", "ti.tree", "ti.radar", "ti.nodata" ];
  var numTiComponent = 0;
  
  var initialize = function() {
    setEventListener();
    setTiscreen();
  };
  
  var setTiscreen = function() {
    var $tiscreen = $("#tiscreen");
    if ($tiscreen.children().length > 2) {
      $("#tiscreen").children(":gt(1)").remove();
      removeAll();
    }
    
    if (tiScreenType == 0) {
      var $gridStatck = $("<div class='grid-stack'/>");
      $tiscreen.append($gridStatck);
      this.grid = $gridStatck.gridstack(options).data("gridstack");
      $("#load").trigger("click");
    } else {
      var $orgDashboard = $("<div class='ti-dashboard'><img src='../../resources/images/tiscreen/org_dashboard.png' /></div>");
      $tiscreen.append($orgDashboard);
    }
  }
  
  var removeAll = function() {
    grid.removeAll();
    tiComponentItems = {};
  }
  
  var setEventListener = function() {
    $("#add").on("click", function() {
      if (tiScreenType == 1) return;
      addTiComponent(exNode);
    });
    $("#addMany").on("click", function() {
      if (tiScreenType == 1) return;
      for (var iCnt = 0; iCnt < 20; iCnt++) {
        addTiComponent(exNode);
      }
    });
    $("#removeAll").on("click", function() {
      if (tiScreenType == 1) return;
      removeAll();
    });
    $("#save").on("click", function() {
      if (tiScreenType == 1) return;
      var nodes = grid.grid.nodes;
      var saveNodes = new Array();
      for (var iCnt = 0; iCnt < nodes.length; iCnt++) {
        var node = tiCommon.deepCopy(nodes[iCnt]);
        delete node["el"];
        delete node["_grid"];
        node["autoPosition"] = false;
        saveNodes.push(node);
      }
      tiCommon.setLocalStorage("tiscreen_data", JSON.stringify(saveNodes));
      alert("저장완료~!");
    });
    $("#load").on("click", function() {
      if (tiScreenType == 1) return;
      var jsonNodes = tiCommon.getLocalStorage("tiscreen_data");
      if (tiCommon.convertToBoolean(jsonNodes)) {
        grid.removeAll();
        var nodes = JSON.parse(jsonNodes);
        for (var iCnt = 0; iCnt < nodes.length; iCnt++) {
          addTiComponent(nodes[iCnt]);
        }
      }
    });
    $("#refresh").on("click", function() {
      if (tiScreenType == 1) return;
      for (var key in tiComponentItems) {
        tiComponentItems[key].refresh();
      }
    });
    $("#change").on("click", function() {
      tiScreenType = (tiScreenType == 0) ? 1 : 0;
      setTiscreen();
    });
  }
  
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
    var name = tiComp[tiCommon.randomRange(0, 6)];
    $("#" + tiComponentId).load("/load.do", {"tiComponentId" : tiComponentId, 
      "numTiComponent" : numTiComponent, "name": name, 
      "title" : "ID : " + tiComponentId + ", Class : " + name});

    numTiComponent++;
  };
  
  initialize();
  
});
</script>

</head>
<body>
<div class="tiscreen_dashboard">
  <!-- header -->
  <div class="header">
    <div class="inner">
      <h1><img src="../../resources/images/tiscreen/ticontroller.svg" alt="" /></h1>
      <div class="notice dl_bx">
        <dl>
          <dt><span class="icon"></span>공지사항</dt>
          <dd>
            <ul>
              <li>안녕하세요. TiController에 오신 것을 환영합니다.</li>
              <li>TiController는 신개념 클라우드 서비스 제품입니다.</li>
            </ul>
          </dd>
        </dl>
      </div>
      <div class="current_time dl_bx">
        <dl>
          <dt><span class="icon"></span>현재시간</dt>
          <dd><span></span></dd>
        </dl>
      </div>
      <div class="util">
        <ul>
          <li>
            <button type="button" title="새로고침" class="reload" onClick=""><span class="icon"></span></button>
          </li>
          <li>
            <button type="button" title="설정" class="setting" onClick=""><span class="icon"></span></button>
          </li>
          <li>
            <button type="button" title="닫기" class="close" onClick=""><span class="icon"></span></button>
          </li>
        </ul>
      </div>
    </div>
  </div>
  <!-- header | end -->
  <div id="tiscreen">
    <div>
      <input id="add" type="button" value="Add TiComponent" style="color: red; font-size: 20px;font-weight: bold;"/>
      <input id="addMany" type="button" value="Add TiComponent Many" style="color: red; font-size: 20px;font-weight: bold;"/>
      <input id="removeAll" type="button" value="Remove All" style="color: red; font-size: 20px;font-weight: bold;"/>
      <input id="save" type="button" value="Save" style="color: red; font-size: 20px;font-weight: bold;"/>
      <input id="load" type="button" value="Load" style="color: red; font-size: 20px;font-weight: bold;"/>
      <input id="refresh" type="button" value="Auto Refresh (2000ms) : 고장" style="color: red; font-size: 20px;font-weight: bold;"/>
      <input id="change" type="button" value="dashboard type change" style="color: red; font-size: 20px;font-weight: bold;"/>
    </div><br/>
  </div>
</div>
</body>
</html>
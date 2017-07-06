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

  console.log("%cTiScreen", "font:8em Arial;color:#EC6521;font-weight:bold");
  
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
    if ($tiscreen.children().length > 0) {
      $("#tiscreen").children(":gt(0)").remove();
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
    var name = tiComp[tiCommon.randomRange(0, 7)];
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
            <button type="button" title="설정" class="dashboard_setting" onClick=""><span class="icon"></span></button>
          </li>
          <li>
            <button type="button" title="닫기" class="close" onClick=""><span class="icon"></span></button>
          </li>
        </ul>
      </div>
    </div>
  </div>
  <!-- header | end -->
    <!-- dashboard_control -->
  <div class="dashboard_control">
    <div class="inner">
      <dl>
        <dt>대시보드 설정</dt>
        <!-- 대시보드 선택 -->
        <dd class="dropdown dashboard_name"><button type="button" class="dropdown_toggle">네트워크 모니터링<span class="caret"></span></button>
          <div class="dropdown_layer">
            <ul>
              <li><a href="#">통합 대시보드</a></li>
              <li><a class="label">기본 대시보드</a>
                <ul>
                  <li><a href="#" class="selected">보안 모니터링</a></li>
                  <li><a href="#">자산 모니터링</a></li>
                  <li><a href="#">트래픽 모니터링</a></li>
                  <li><a href="#">네트워크 모니터링</a></li>
                </ul>
              </li>
              <li><a class="label">나의 대시보드</a>
                <ul>
                  <li><a href="#">보안 모니터링</a><button class="delete" title="삭제"><span class="icon"></span></button></li>
                  <li><a href="#">자산 모니터링</a><button class="delete" title="삭제"><span class="icon"></span></button></li>
                  <li><a href="#">트래픽 모니터링</a><button class="delete" title="삭제"><span class="icon"></span></button></li>
                  <li><a href="#">네트워크 모니터링</a><button class="delete" title="삭제"><span class="icon"></span></button></li>
                </ul></li>
            </ul>
          </div>
        </dd>
        <!-- 대시보드 선택 -->
        <dd><button type="button" title="저장" class="save_dashboard"><span class="icon"></span><span class="txt">저장</span></button></dd>
        <dd><button type="button" title="추가" class="add_dashboard"><span class="icon"></span><span class="txt">추가</span></button></dd>
        <dd><button type="button" title="복제" class="clone_dashboard"><span class="icon"></span><span class="txt">복제</span></button></dd>
        <dd class="bar">|</dd>
        <!-- 컴포넌트 추가 -->
        <dd class="dropdown"><button type="button" title="컴포넌트 추가" class="dropdown_toggle add_component"><span class="icon"></span><span class="txt">컴포넌트 추가</span><span class="caret"></span></button>
          <div class="dropdown_layer">
            <ul>
              <li><a class="label">예제</a>
                <ul>
                  <li><a href="#">No data</a></li>
                </ul>
              </li>
              <li><a class="label">차트</a>
                <ul>
                  <li><a href="#">파이</a></li>
                  <li><a href="#">라인</a></li>
                  <li><a href="#">바</a></li>
                  <li><a href="#">히트맵</a></li>
                  <li><a href="#">레이더</a></li>
                </ul>
              </li>
              <li><a class="label">그외</a>
                <ul>
                  <li><a href="#">테이블</a></li>
                  <li><a href="#">트리</a></li>
                </ul>
              </li>
            </ul>
          </div>
        </dd>
        <!-- 컴포넌트 추가 | end -->
        <dd><button type="button" id="add" class="clone_dashboard"><span class="icon"></span><span class="txt">추가</span></button></dd>
        <dd><button type="button" id="addMany" class="clone_dashboard"><span class="icon"></span><span class="txt">추가(20)</span></button></dd>
        <dd><button type="button" id="removeAll" class="clone_dashboard"><span class="icon"></span><span class="txt">삭제</span></button></dd>
        <dd><button type="button" id="save" class="clone_dashboard"><span class="icon"></span><span class="txt">저장</span></button></dd>
        <dd><button type="button" id="load" class="clone_dashboard"><span class="icon"></span><span class="txt">로드</span></button></dd>
        <dd><button type="button" id="refresh" class="clone_dashboard"><span class="icon"></span><span class="txt">새로고침</span></button></dd>
        <dd><button type="button" id="change" class="clone_dashboard"><span class="icon"></span><span class="txt">전환</span></button></dd>
      </dl>
    </div>
  </div>  
  <!-- dashboard_control | end -->
  <div id="tiscreen">
  </div>
</div>
</body>
</html>
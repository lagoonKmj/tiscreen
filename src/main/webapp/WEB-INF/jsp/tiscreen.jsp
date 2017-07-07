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
var numTiComponent = 0;
var dashboardComponents = ${dashboardComponents};
var dashboardComponentItems = new Object();

$(function () {

  console.log("%cTiScreen", "font:8em Arial;color:#EC6521;font-weight:bold");
  
  var options = {
      float: false,
      cellHeight: 80,
      verticalMargin: 5,
      handleClass : "grid-stack-item-content-header",
      animate : true
  };
  
  var initialize = function() {
    setTiscreen();
    setEventListener();
  };
  
  var setTiscreen = function() {
    //
    $(dashboardComponents).each(function(idx, element) {
      var $html = $("<li><a>" + element.name + "</a></li>").addClass("dashboardComponent").data("class-item", element);
      if (element.division == 1) {
        ($("#compCommon").css("display") == "none") ? $("#compCommon").show() : "";
        $("#compCommon ul").append($html);
      } else if (element.division == 2) {
        ($("#compNetwork").css("display") == "none") ? $("#compNetwork").show() : "";
        $("#compNetwork ul").append($html);
      } else if (element.division == 3) {
        ($("#compTimatrix").css("display") == "none") ? $("#compTimatrix").show() : "";
        $("#compTimatrix ul").append($html);
      } else if (element.division == 4) {
        ($("#compNdm").css("display") == "none") ? $("#compNdm").show() : "";
        $("#compNdm ul").append($html);
      }
      //Map 저장
      dashboardComponentItems[element.id] = element;
    });
    //
    var $tiscreen = $("#tiscreen");
    if ($tiscreen.children().length > 0) {
      $("#tiscreen").children(":gt(0)").remove();
      removeAll();
    }
    
    if (tiScreenType == 0) {
      var $gridStatck = $("<div class='grid-stack'/>");
      $tiscreen.append($gridStatck);
      this.grid = $gridStatck.gridstack(options).data("gridstack");
     
      var jsonNodes = tiCommon.getLocalStorage("tiscreen_data");
      if (tiCommon.convertToBoolean(jsonNodes)) {
        grid.removeAll();
        var nodes = JSON.parse(jsonNodes);
        for (var iCnt = 0; iCnt < nodes.length; iCnt++) {
          var node = nodes[iCnt];
          if (dashboardComponentItems.hasOwnProperty(node.id)) {
            node.class_name = dashboardComponentItems[node.id].class_name; 
            node.name = dashboardComponentItems[node.id].name; 
            addTiComponent(node);
          }
        }
      }
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
    $("#removeAll").on("click", function() {
      if (tiScreenType == 1) return;
      removeAll();
    });
    $(".save_dashboard").on("click", function() {
      if (tiScreenType == 1) return;
      var nodes = grid.grid.nodes;
      var saveNodes = new Array();
      for (var iCnt = 0; iCnt < nodes.length; iCnt++) {
        var node = tiCommon.deepCopy(nodes[iCnt]);
        delete node["el"];
        delete node["_grid"];
        node["autoPosition"] = false;
        node["class_name"] = node.id;
        saveNodes.push(node);
      }
      tiCommon.setLocalStorage("tiscreen_data", JSON.stringify(saveNodes));
      alert("저장완료~!");
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
    $(".dashboardComponent").on("click", function() {
      var node = $(this).data("class-item");
      node.x = 0; 
      node.y = 0;
      node.width = 4;
      node.height = 3;
      node.auto_position = true;
      if (tiCommon.convertToBoolean(node.class_name)) {
        addTiComponent(node);
      } else {
        console.warn("[ERROR] conf_dashboard_component 테이블에 class_name을 정의 하십시요.");
      }
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
    
    var className = node.class_name;
    grid.addWidget(
        $.parseHTML(tiComponent), 
        node.x, 
        node.y, 
        node.width, 
        node.height,
        node.auto_position,
        node.min_width,
        node.max_width,
        node.min_height,
        node.max_height,
        node.id
        );
    
    $("#" + tiComponentId).load("/load.do", {"tiComponentId" : tiComponentId, 
      "numTiComponent" : numTiComponent, "className": className, "title" : node.name});
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
          <div class="dropdown_layer" id="selectDashboard">
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
          <div class="dropdown_layer" id="selectComponent">
            <ul>
              <li id="compCommon" style="display: none;"><a class="label">공통</a>
                <ul></ul>
              </li>
              <li id="compNetwork" style="display: none;"><a class="label">장비</a>
                <ul></ul>
              </li>
              <li id="compTimatrix" style="display: none;"><a class="label">보안</a>
                <ul></ul>
              </li>
              <li id="compNdm" style="display: none;"><a class="label">NDM</a>
                <ul></ul>
              </li>
            </ul>
          </div>
        </dd>
        <!-- 컴포넌트 추가 | end -->
        <dd><button type="button" id="removeAll" class="clone_dashboard"><span class="icon"></span><span class="txt">삭제</span></button></dd>
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
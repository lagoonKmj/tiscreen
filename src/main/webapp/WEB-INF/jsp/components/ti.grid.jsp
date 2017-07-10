<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="grid-stack-item-content-container" id="${tiContainerId}"></div>

<script type="text/javascript">
  
  //티컴포넌트 초기화
  var initialize = function() {
    var tiComponentId = "#" + "${tiComponentId}";
    var tiContainerId = "#" + "${tiContainerId}";
    var componentId = "${id}"; 
    tiComponentItems[tiComponentId] = $(tiContainerId).tiComponent({
      tiComponentId : tiComponentId,
      tiContainerId : tiContainerId,
      componentId : componentId,
      url : "/getData.json"
    });
    tiComponentItems[tiComponentId].initialize();
  };
  
  var ready = function($tiComponent) {
    //TODO 티컴포넌트 준비완료(차트 등 컨텐츠를 생성후 div에 추가 합니다.)
  };
  
  var setComponentPara = function() {
    //TODO 티컴포넌트에 추가적인 파라미터 필요할때 구현
  };

  var setPageEventListener = function() {
    //TODO 티컴포넌트에 추가적인 이벤트 필요할때 구현
  };

  var onResizestop = function($tiComponent) {
    //TODO 티컴포넌트 리사이즈가 종료되면 실행
  };

  var refresh = function($tiComponent) {
    //TODO 티컴포넌트에 새로고침 이벤트가 발생되면 실행
  };
  
  initialize();
  
</script>
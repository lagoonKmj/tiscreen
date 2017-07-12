<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="grid-stack-item-content-container" id="${tiContainerId}"></div>

<script type="text/javascript">

$(function () {

  //시작
  var initialize = function() {
    var tiComponentId = "#" + "${tiComponentId}";
    var tiContainerId = "#" + "${tiContainerId}";
    var componentId = "${id}"; 
    //옵션(아래 정의되어 있는 옵션사항은 필수)
    var options = {
      tiComponentId : tiComponentId,
      tiContainerId : tiContainerId,
      url : "/tiscreen/getData.json",
      componentId : componentId
    };
    //함수(afterContentInit() 필수, 나머지는 선택)
    var functions = {
        afterContentInit : function($tiComponent) {
          //TODO 티컴포넌트 준비완료(차트 등 컨텐츠를 생성후 div에 추가 합니다.)
          //$tiComponent.getContent(); // Ajax 호출 결과 데이터를 가져옵니다.
        },
        setComponentPara : function() {
          //TODO 티컴포넌트에 추가적인 파라미터 필요할때 구현
        },
        setPageEventListener : function() {
          //TODO 티컴포넌트에 추가적인 이벤트 필요할때 구현
        },
        onResizestop : function($tiComponent) {
          //TODO 티컴포넌트 리사이즈가 종료되면 실행
        }
    };
    //티컴포넌트 생성 및 초기화
    tiComponentItems[tiComponentId] = $(tiContainerId).tiComponent(options, functions);
    tiComponentItems[tiComponentId].initialize();
  };
  
  initialize();
  
});

</script>
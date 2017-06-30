<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="grid-stack-item-content-container" id="${tiContainerId}"></div>

<script type="text/javascript">
  var initialize = function() {
    var tiComponentId = "#" + "${tiComponentId}";
    var tiContainerId = "#" + "${tiContainerId}";
    tiComponentItems[tiComponentId] = $(tiContainerId).tiComponent({
      tiComponentId : tiComponentId,
      tiContainerId : tiContainerId,
      title : "${title}",
      minWidth : 2, 
      minHeight : 2, 
      maxWidth : 8, 
      maxHeight : 8
    });
    tiComponentItems[tiComponentId].initialize();
  };
  
  //true : 데이터 미존재, false : 데이터 존재 가정
  var ready = function($tiComponent) {
    //시나리오1 : 데이터 처리 후 보여줄 데이터 가 없음
    if (true) { //데이터 미존재(No data)
      $tiComponent.setNodata();
    } else {    //데이터 존재
      //TODO 구현
    }
  };
  
  var onResizestop = function($tiComponent) {
  };
  
  var refresh = function($tiComponent) {
    //시나리오2 : 새로고침. 보여줄 데이터가 존재
    var isNodata = $tiComponent.getNodataStatus(); //현재 상황 가져오기
    if (isNodata) { //No data 진행중
      if (false)    //데이터 존재
        //1. No data 영역 삭제
        //2. TODO 구현
      } //else { 무시 }  
    } else {        //컨텐츠 진행중
      if (true) {   //데이터 미존재
        //1. 컨텐츠 영역 삭제
        $tiComponent.setNodata(); //2. No data 영역 추가 
      } //else { 컨텐츠 새로고침 }
    }
  };
  
  initialize();
</script>
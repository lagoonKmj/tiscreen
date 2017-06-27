"use strict";
(function($) {
  $.fn.tiComponent = function(options) {
    /**
     * Variable
     */
    var $opts = $.extend({}, $.fn.tiComponent.defaults, options);
    var curThis = this, $curThis = $(curThis);
    var objParam = null;
    /**
     * new _component
     */
    var _component = function() {
      //#
      $opts.tiComponentId = "#" + $opts.tiComponentId;
      $opts.tiContainerId = "#" + $opts.tiContainerId;
      //Checked Required
      if (!comm.convertToBoolean($opts.title)) {
        console.error("[ERROR] title 필수 옵션!!!");
      }
    };
    /**
     * 외부 함수
     */
    _component.prototype = {
        //Initialize
        initialize : function() {
          //헤더 추가
          _innerMethod.appendCommonTag();
          //파라미터 셋
          _innerMethod.setPara();
          //이벤트 리스너
          _innerMethod.setEventListener();
          //시작
          _innerMethod.ready();
        },
        getId : function() {
          return $opts.tiComponentId;
        },
        getCurThis : function() {
          return $curThis;
        }
    };
    
    /**
     * 내부 함수
     */
    var _innerMethod = {
        //Append common tag
        appendCommonTag : function() {
          var strHtml = "<div class='grid-stack-item-content-header'>";
          strHtml += "     <h2>Title...</h2>";
          strHtml += "     <ul>";
          strHtml += "     		<li class='config'>설정</li>";
          strHtml += "        <li class='delete'>삭제</li>";
          strHtml += "     </ul>";
          strHtml += "</div>";
          $($opts.tiContainerId).before(strHtml);
        },
        //Set Para
        setPara : function() {
          //타이틀
          if (comm.convertToBoolean($opts.title)) {
            ($opts.isLog) ? console.log("1. 타이틀 설정 : " + $opts.title) : "";
            $($opts.tiComponentId + " .grid-stack-item-content-header h2").text($opts.title);
          }
          //페이지 파라미터 설정
          if (typeof setComponentPara === "function") {
            ($opts.isLog) ? console.log("2. 티컴포넌트 파라미터 추가 설정") : "";
            setComponentPara();
          } else {
            ($opts.isLog) ? console.log("2. 티컴포넌트 파라미터 추가 설정 없음.") : "";
          }
        },
        //이벤트 제거
        removeEventListener : function() {
          ($opts.isLog) ? console.log("99. 컴포넌트 삭제. id : " + $opts.tiComponentId + ", name : " + $opts.title) : "";
        },
        //이벤트 추가
        setEventListener : function() {
          ($opts.isLog) ? console.log("3. 이벤트 설정 : 삭제, 설정") : "";
          $($opts.tiComponentId).on("click", function(event) {
            var $target = $(event.target);
            if ($target.is(".delete")) {
              grid.removeWidget($(this).parents().eq(0));
              _innerMethod.removeEventListener();
            }
            if ($target.is(".config")) {
              console.log("설정");
              _innerMethod.ready();
            }
          });
          //페이지 이벤트 설정
          if (typeof setPageEventListener === "function") {
            ($opts.isLog) ? console.log("4. 티컴포넌트 이벤트 추가 설정") : "";
            setPageEventListener();
          } else {
            ($opts.isLog) ? console.log("4. 티컴포넌트 이벤트 추가 설정 없음.") : "";
          }
        },
        //새로고침
        refresh : function() {
        },
        //시작
        ready : function() { 
          if (typeof ready === "function") {
            ($opts.isLog) ? console.log("5. 티컴포넌트 설정 완료.") : "";
            ready($curThis);
          } else {
            console.error("[ERROR]ready() 함수를 정의 및 구현 하십시요.");
          }
        },
    }
    
    return new _component;
  };
  
  $.fn.tiComponent.defaults = {
      tiComponentId : null,
      tiContainerId : null,
      title : null,
      isLog : true
  };
})(jQuery);
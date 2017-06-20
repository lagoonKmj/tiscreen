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
      //Checked Required
      if (!comm.convertToBoolean($opts.title)) {
        console.log("[E] title 필수 옵션!!!");
      }
    };
    /**
     * 외부 함수
     */
    _component.prototype = {
        //Initialize
        initPage : function() {
          //파라미터 셋
          _innerMethod.setPara();
          //이벤트 리스너
          _innerMethod.setEventListener();
        },
        getId : function() {
          return $opts.id;
        }
    };
    
    /**
     * 내부 함수
     */
    var _innerMethod = {
        //Set Para
        setPara : function() {
          //타이틀
          if (comm.convertToBoolean($opts.title)) {
            console.log("1. 타이틀 셋팅 : " + $opts.id);
          }
          //페이지 파라미터 설정
          if (typeof setComponentPara === "function") {
            setComponentPara();
          }
        },

        //데이터가져오기 처리
        getData : function(callback){},

        //초기데이터 가져온후 처리
        onInitData : function(rows) {
        },

        //이벤트 제거
        removeEventListener : function() {
        },
        
        //이벤트 추가
        setEventListener : function() {
          //새로고침
          $('.ui-icon-refresh').on("click", function(event) {
          });
          _innerMethod.removeEventListener();
          $curThis.on("click", function() {
            test( $opts.id);
          });
        },
        //새로고침
        refresh : function() {
        }
    }
    
    return new _component;
  };
  
  $.fn.tiComponent.defaults = {
      id : null,
      title : null
  };
})(jQuery);
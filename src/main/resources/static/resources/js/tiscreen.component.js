"use strict";
(function($) {
  $.fn.tiComponent = function(options) {
    /**
     * Variable
     */
    var $opts = $.extend({}, $.fn.tiComponent.defaults, options);
    var $tiComponent = $($opts.tiComponentId), $currentTarget = $tiComponent.parent();
    var $tiContainer = $($opts.tiContainerId);
    var isNodata = false, headerAreaHeight = 35;
    /**
     * new _component
     */
    var _component = function() {
      //Checked Required
      if (!tiCommon.convertToBoolean($opts.title)) {
        console.warn("[ERROR] title 필수 옵션!!!");
      }
      if (!tiCommon.convertToBoolean($opts.url)) {
        console.warn("[ERROR] url 필수 옵션!!!");
      }
    };
    /**
     * 외부 함수
     */
    _component.prototype = {
        //Initialize
        initialize : function() {
          ($opts.isLog) ? console.log("################################################ START") : "";
          ($opts.isLog) ? console.log("1. 티컴포넌트 생성  ID: " + $opts.tiComponentId) : "";
          //gird 옵션 재정의
          ($opts.isLog) ? console.log("2. 최대넓이 : " + $opts.maxWidth + ", 최대높이 : " + $opts.maxHeight + ", 최소넓이 : " + $opts.minWidth + ", 최소높이 : " + $opts.minHeight) : "";
          {
            grid.maxWidth($currentTarget, $opts.maxWidth);
            grid.maxHeight($currentTarget, $opts.maxHeight);
            grid.minWidth($currentTarget, $opts.minWidth);
            grid.minHeight($currentTarget, $opts.minHeight);
          }
          //헤더 추가
          _innerMethod.appendHeaderTag();
          //파라미터 셋
          _innerMethod.setPara();
          //이벤트 리스너 셋
          _innerMethod.setEventListener();
          //데이터 겟
          _innerMethod.getData();
        },
        getTiComponentId : function() {
          return $opts.tiComponentId;
        },
        getTiContainerId : function() {
          return $opts.tiContainerId;
        },
        getRectangle : function() {
          return {
            "posX" : $tiComponent.offset().left,
            "posY" : $tiComponent.offset().top,
            "width" : $tiComponent.width(),
            "height" : $tiComponent.height() - headerAreaHeight,
          };
        },
        refresh : function() {
          _innerMethod.refresh();
        }, 
        setNodata : function() {
          if (isNodata) {
            var $taget = $(".no_data_content");
            if ($taget.length > 0) {
              $taget.remove();
            }
          } else {
            var strHtml = "<div class='no_data_content'>";
            strHtml += "     <span class='icon'></span>";
            strHtml += "     <span class='text'>" + $opts.nodataMessage + "</span>";
            strHtml += "   </div>";
            $tiContainer.addClass("no_data").append(strHtml);
          }
          isNodata = !isNodata;  
          
        },
        getNodataStatus : function() {
          return isNodata;
        }
    };
    
    /**
     * 내부 함수
     */
    var _innerMethod = {
        //Append Header tag
        appendHeaderTag : function() {
          var strHtml = "<div class='grid-stack-item-content-header'>";
          strHtml += "     <h2>Title...</h2>";
          if ($opts.isInformation) {
            strHtml += "     <span class='monitoring_time'>2017-06-20 12:00:00 ~2017-06:21 12:00:00</span>";
          }
          strHtml += "     <ul>";
          if ($opts.isConfig) {
            strHtml += "     		<li>";
            strHtml += "     		  <button type='button' title='설정' class='setting'><span class='icon'></span></button>";
            strHtml += "        </li>";
          }
          strHtml += "     		<li>";
          strHtml += "          <button type='button' title='닫기' class='close'><span class='icon'></span></button>";
          strHtml += "        </li>";
          strHtml += "     </ul>";
          strHtml += "</div>";
          $tiContainer.before(strHtml);
        },
        //Set Para
        setPara : function() {
          //타이틀
          if (tiCommon.convertToBoolean($opts.title)) {
            ($opts.isLog) ? console.log("3. 타이틀 설정 : " + $opts.title) : "";
            $($opts.tiComponentId + " .grid-stack-item-content-header h2").text($opts.title);
          }
          //페이지 파라미터 설정
          if (typeof setComponentPara === "function") {
            ($opts.isLog) ? console.log("4. 티컴포넌트 파라미터 추가 설정") : "";
            setComponentPara();
          } else {
            ($opts.isLog) ? console.log("4. 티컴포넌트 파라미터 추가 설정 없음.") : "";
          }
        },
        //이벤트 제거
        removeEventListener : function() {
        },
        //이벤트 추가
        setEventListener : function() {
          ($opts.isLog) ? console.log("5. 이벤트 설정 : 삭제, 설정, 리사이즈") : "";
          //클릭
          $tiComponent.on("click", function(event) {
            var $target = $(event.target);
            if ($target.is(".close")) {
              grid.removeWidget($currentTarget);
              _innerMethod.removeEventListener();
              delete tiComponentItems[$opts.tiComponentId];
              ($opts.isLog) ? console.log("99. 컴포넌트 삭제. id : " + $opts.tiComponentId + ", name : " + $opts.title) : "";
            }
            if ($target.is(".setting")) {
              if (typeof onConfig === "function") {
                onConfig(_innerMethod.getTiComponentItem());
              } else {
                console.warn("[INFO] onConfig() 함수를 정의 및 구현 하십시요.");
              }
            }
          });
          //리사이즈
          $currentTarget.on("resizestop", function(event) {
            //하이차트 리사이즈 이벤트 처리(300ms 딜레이)
            if ($opts.isHighCharts) {
              setTimeout(function() {
                var rect = _component.prototype.getRectangle();
                var chart = $tiContainer.highcharts();
                chart.setSize(rect.width, rect.height, true);
                chart.reflow();
              }, 300);
            } else {
              if (typeof onResizestop === "function") {
                onResizestop(_innerMethod.getTiComponentItem());
              } else {
                console.warn("[INFO] onResizestop() 함수를 정의 및 구현 하십시요.");    
              }
            }
          });
          //페이지 별 (추가)이벤트 설정
          if (typeof setPageEventListener === "function") {
            ($opts.isLog) ? console.log("6. 티컴포넌트 이벤트 추가 설정") : "";
            setPageEventListener();
          } else {
            ($opts.isLog) ? console.log("6. 티컴포넌트 이벤트 추가 설정 없음.") : "";
          }
        },
        //새로고침
        refresh : function() {
          if (typeof refresh === "function") {
            ($opts.isLog) ? console.log("99. 새로고침. id : " + $opts.tiComponentId + ", name : " + $opts.title) : "";
            refresh(_innerMethod.getTiComponentItem());
          } else {
            console.warn("[INFO] refresh() 함수를 정의 및 구현 하십시요.");
          }
        },
        //데이터 가져오기
        getData : function() {
          if (typeof ready === "function") {
            ($opts.isLog) ? console.log("7. 티컴포넌트 설정 완료.") : "";
            ready(_innerMethod.getTiComponentItem());
          } else {
            console.warn("[ERROR] ready() 함수를 정의 및 구현 하십시요.");
          }
            
          ($opts.isLog) ? console.log("################################################ END") : "";
        },
        //TiComponent Item
        getTiComponentItem : function() {$opts.url
          return tiComponentItems[$opts.tiComponentId];
        }
    }
    
    return new _component;
  };
  
  $.fn.tiComponent.defaults = {
      tiComponentId : null, // 컴퍼넌트 ID 정의 (e.g : component_1)
      tiContainerId : null, // 컨테이너 ID 정의 (e.g : container_1)
      title : null, // 컴퍼넌트 타이틀 정의
      minHeight : 2, // 컴퍼넌트 최소 높이 정의
      minWidth : 2, // 컴퍼넌트 최소 넓이 정의
      maxHeight : 8, // 컴퍼넌트 최대 높이 정의
      maxWidth : 8, // 컴퍼넌트 최대 넓이 정의
      isLog : true, // 콘솔로그 유무
      isHighCharts : false, // 하이차트 유무
      nodataMessage : "No data", // 데이터없을시 출력될 메세지
      url : null, // Ajax 호출 URL
      isConfig : false, // 설정기능 유무
      isInformation : false // (타이틀영역 옆) 정보창 유무
  };
})(jQuery);
"use strict";
(function($) {
  $.fn.tiComponent = function(options, functions) {
    /**
     * Variable
     */
    var $opts = $.extend({}, $.fn.tiComponent.defaults, options);
    var $tiComponent = $($opts.tiComponentId);
    var $currentTarget = $tiComponent.parent();
    var $tiContainer = $($opts.tiContainerId);
    var isNodata = false;
    var headerAreaHeight = 35;
    var componentItem = dashboardComponentItems[$opts.componentId];
    var tiFunctions = functions;
    var totalElements = NaN;
    var content = null;
    /**
     * new _component
     */
    var _component = function() {
      //Checked Required
      if (!tiCommon.convertToBoolean($opts.tiComponentId)) {
        console.warn("[ERROR] tiComponentId 필수 옵션!!!");
      }
      if (!tiCommon.convertToBoolean($opts.tiContainerId)) {
        console.warn("[ERROR] tiContainerId 필수 옵션!!!");
      }
      if (!tiCommon.convertToBoolean($opts.componentId)) {
        console.warn("[ERROR] componentId 필수 옵션!!!");
      }
      if (!tiCommon.convertToBoolean($opts.url)) {
        console.warn("[ERROR] url 필수 옵션!!!");
      }
      //Set Options(값이 존재 안할시 DB에 있는 데이터로 처리)
      if (!tiCommon.convertToBoolean($opts.title)) {
        $opts.title = componentItem.name;
      }
      if ($opts.isConfig == null) {
        $opts.isConfig = tiCommon.convertToBoolean(componentItem.is_config);
      }
      if ($opts.isInformation == null) {
        $opts.isInformation = tiCommon.convertToBoolean(componentItem.is_information);
      }
      if (isNaN($opts.minHeight)) {
        $opts.minHeight = componentItem.min_height;
      }
      if (isNaN($opts.minWidth)) {
        $opts.minWidth = componentItem.min_width;
      }
      if (isNaN($opts.maxHeight)) {
        $opts.maxHeight = componentItem.max_height;
      }
      if (isNaN($opts.maxWidth)) {
        $opts.maxWidth = componentItem.max_width;
      }
    };
    /**
     * 외부 함수
     */
    _component.prototype = {
        //Initialize
        initialize : function() {
          ($opts.isLog) ? console.log("%cSTART{", "font:1em Arial;color:#CB6CFF;font-weight:bold") : "";
          ($opts.isLog) ? console.log("1. 티컴포넌트 생성 ID: " + $opts.tiComponentId) : "";
          ($opts.isLog) ? console.log("2. 최대넓이 : " + $opts.maxWidth + ", 최대높이 : " + $opts.maxHeight + 
              ", \n   최소넓이 : " + $opts.minWidth + ", 최소높이 : " + $opts.minHeight +
              ", \n   타이틀 : " + $opts.title +
              ", \n   설정버튼 : " + $opts.isConfig +
              ", \n   정보영역 : " + $opts.isInformation +
              ", \n   차트유무 : " + $opts.isHighCharts +
              ", \n   노데이터메세지 : " + $opts.nodataMessage +
              ", \n   URL : " + $opts.url) : "";
          //gird 옵션 재정의
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
          
          ($opts.isLog) ? console.log("%c} END", "font:1em Arial;color:#CB6CFF;font-weight:bold") : "";
          
        },
        getTiComponentId : function() {
          return $opts.tiComponentId;
        },
        getTiContainerId : function() {
          return $opts.tiContainerId;
        },
        getTiContainerIdRemoveSharp : function() {
          return ($opts.tiContainerId).substring(1);
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
        setParam : function(value) {
          $opts.objParam = value;
        },
        getTotalElements : function () {
          return totalElements;
        },
        getContent : function () {
          return content;
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
          if (typeof tiFunctions.setComponentPara === "function") {
            ($opts.isLog) ? console.log("4. 티컴포넌트 파라미터 추가 설정") : "";
            tiFunctions.setComponentPara();
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
            var $target = $(event.target).parent();
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
              if (typeof tiFunctions.onResizestop === "function") {
                tiFunctions.onResizestop(_innerMethod.getTiComponentItem());
              } else {
                console.warn("[INFO] onResizestop() 함수를 정의 및 구현 하십시요.");    
              }
            }
          });
          //페이지 별 (추가)이벤트 설정
          if (typeof tiFunctions.setPageEventListener === "function") {
            ($opts.isLog) ? console.log("6. 티컴포넌트 이벤트 추가 설정") : "";
            tiFunctions.setPageEventListener();
          } else {
            ($opts.isLog) ? console.log("6. 티컴포넌트 이벤트 추가 설정 없음.") : "";
          }
        },
        //새로고침
        refresh : function() {
          ($opts.isLog) ? console.log("99. 새로고침. id : " + $opts.tiComponentId + ", name : " + $opts.title) : "";
          _innerMethod.getData();
        },
        //Ajax 호출
        getData : function() {
          $.get($opts.url, $opts.objParam, function(data) {
            totalElements = data.total_elements;
            content = data.content;
            if (isNodata) { //No data 진행중
              if (totalElements > 0) {   //데이터 존재
                _innerMethod.setNodata();
                _innerMethod.afterContentInit();
              }  
            } else {
              if (totalElements > 0) {   //데이터 존재
                _innerMethod.afterContentInit();
              } else {
                _innerMethod.removeTiContainerchildren();
                _innerMethod.setNodata();
              }
            }
          });
        },
        //TiComponent Item
        getTiComponentItem : function() {$opts.url
          return tiComponentItems[$opts.tiComponentId];
        },
        setNodata : function() {
          if (isNodata) {
            _innerMethod.removeTiContainerchildren();
          } else {
            var strHtml = "<div class='no_data_content'>";
            strHtml += "     <span class='icon'></span>";
            strHtml += "     <span class='text'>" + $opts.nodataMessage + "</span>";
            strHtml += "   </div>";
            $tiContainer.addClass("no_data").append(strHtml);
          }
          isNodata = !isNodata;  
          
        },
        afterContentInit : function() {
          if (typeof tiFunctions.afterContentInit === "function") {
            tiFunctions.afterContentInit(_innerMethod.getTiComponentItem());
          } else {
            console.warn("[ERROR] afterContentInit() 함수를 정의 및 구현 하십시요.");
          }
        },
        removeTiContainerchildren : function() {
          var $taget = $tiContainer.children();
          if ($taget.length > 0) {
            $taget.remove();
            $tiContainer.removeClass("no_data");
          }
        }
    }
    
    return new _component;
  };
  
  $.fn.tiComponent.defaults = {
      tiComponentId : null, // 컴퍼넌트 ID 정의 (e.g : component_1)
      tiContainerId : null, // 컨테이너 ID 정의 (e.g : container_1)
      title : null, // 컴퍼넌트 타이틀 정의
      minHeight : NaN, // 컴퍼넌트 최소 높이 정의
      minWidth : NaN, // 컴퍼넌트 최소 넓이 정의
      maxHeight : NaN, // 컴퍼넌트 최대 높이 정의
      maxWidth : NaN, // 컴퍼넌트 최대 넓이 정의
      isLog : false, // 콘솔로그 유무
      isHighCharts : null, // 하이차트 유무
      nodataMessage : "No data", // 데이터없을시 출력될 메세지
      url : null, // Ajax 호출 URL
      objParam : null, //Ajax 호출때 넘길 파라미터
      isConfig : null, // 설정기능 유무
      isInformation : null, // (타이틀영역 옆) 정보창 유무
      componentId : NaN //컴포넌트 ID값을 정의(conf_dashboard_component.id 와 매칭)
  };
})(jQuery);
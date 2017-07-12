<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="grid-stack-item-content-container" id="${tiContainerId}"></div>

<script type="text/javascript">

$(function () {
 
  var initialize = function() {
    var tiComponentId = "#" + "${tiComponentId}";
    var tiContainerId = "#" + "${tiContainerId}";
    var componentId = "${id}";
    var options = {
        tiComponentId : tiComponentId,
        tiContainerId : tiContainerId,
        componentId : componentId,
        isHighCharts : true,
        url : "/tiscreen/getData.json"
    };
    var functions = {
        afterContentInit : function($tiComponent) {
          drawChart($tiComponent);
        }
    };
    tiComponentItems[tiComponentId] = $(tiContainerId).tiComponent(options, functions);
    tiComponentItems[tiComponentId].initialize();
  };
  
  
  var drawChart = function($tiComponent) {
    var rect = $tiComponent.getRectangle();
    Highcharts.chart($tiComponent.getTiContainerIdRemoveSharp(), {
        chart: {
            type: 'pie',
            width: rect.width,
            height: rect.height,
            backgroundColor: "black"
        },
        title: {
            text: 'Browser market shares. January, 2015 to May, 2015',
            style: { "color": "white", "fontSize": "18px" }
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    },
                    connectorColor: 'silver'
                }
            }
        },
        series: [{
            name: 'Brands',
            data: [
                { name: 'IE', y: tiCommon.randomRange(1, 100) },
                { name: 'Chrome', y: tiCommon.randomRange(1, 100), sliced: true, selected: true },
                { name: 'Firefox', y: tiCommon.randomRange(1, 100) },
                { name: 'Safari', y: tiCommon.randomRange(1, 100) }, 
                { name: 'Opera', y: tiCommon.randomRange(1, 100) }
            ]
        }]
    });    
  };
  
//   var refresh = function($tiComponent) {
//     var chart = $($tiComponent.getTiContainerId()).highcharts();
//     var newData = [
//         { name: 'IE', y: tiCommon.randomRange(1, 100) },
//         { name: 'Chrome', y: tiCommon.randomRange(1, 100), sliced: true, selected: true },
//         { name: 'Firefox', y: tiCommon.randomRange(1, 100) },
//         { name: 'Safari', y: tiCommon.randomRange(1, 100) }, 
//         { name: 'Opera', y: tiCommon.randomRange(1, 100) }
//     ];
//     chart.series[0].setData(newData);
//     chart.redraw();
    
//     //
//     setTimeout(function() {
//       $tiComponent.refresh();
//     }, 2000);
//   };
  
  initialize();
  
});

</script>
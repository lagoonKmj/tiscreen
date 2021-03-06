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
            polar: true,
            width: rect.width,
            height: rect.height,
            backgroundColor: "black"
        },
        title: {
          text: 'Highcharts Polar Chart',
          style: { "color": "white", "fontSize": "18px" }
      },

      pane: {
          startAngle: 0,
          endAngle: 360
      },

      xAxis: {
          tickInterval: 45,
          min: 0,
          max: 360,
          labels: {
              formatter: function () {
                  return this.value + '°';
              }
          }
      },

      yAxis: {
          min: 0
      },

      plotOptions: {
          series: {
              pointStart: 0,
              pointInterval: 45
          },
          column: {
              pointPadding: 0,
              groupPadding: 0
          }
      },

      series: [{
          type: 'column',
          name: 'Column',
          data: [8, 7, 6, 5, 4, 3, 2, 1],
          pointPlacement: 'between'
      }, {
          type: 'line',
          name: 'Line',
          data: [1, 2, 3, 4, 5, 6, 7, 8]
      }, {
          type: 'area',
          name: 'Area',
          data: [1, 8, 2, 7, 3, 6, 4, 5]
      }]
    });    
  };
  
  initialize();
  
});

</script>
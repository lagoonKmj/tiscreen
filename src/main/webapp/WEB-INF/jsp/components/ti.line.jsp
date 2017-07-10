<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="grid-stack-item-content-container" id="${tiContainerId}"></div>

<script type="text/javascript">
  var initialize = function() {
    var tiComponentId = "#" + "${tiComponentId}";
    var tiContainerId = "#" + "${tiContainerId}";
    var componentId = "${id}";
    tiComponentItems[tiComponentId] = $(tiContainerId).tiComponent({
      tiComponentId : tiComponentId,
      tiContainerId : tiContainerId,
      componentId : componentId,
      isHighCharts : true,
      url : "/getData.json"
    });
    tiComponentItems[tiComponentId].initialize();
  };
  
  var ready = function() {
    drawChart();
  };
  
  var drawChart = function() {
    var $tiComponent = tiComponentItems["#" + "${tiComponentId}"];
    var rect = $tiComponent.getRectangle();
    Highcharts.chart("${tiContainerId}", {
        chart: {
          width: rect.width,
          height: rect.height,
          backgroundColor: "black"
        },
        title: {
          text: 'Solar Employment Growth by Sector, 2010-2016',
          style: { "color": "white", "fontSize": "18px" }
      },

      subtitle: {
          text: 'Source: thesolarfoundation.com'
      },

      yAxis: {
          title: {
              text: 'Number of Employees'
          }
      },
      legend: {
          layout: 'vertical',
          align: 'right',
          verticalAlign: 'middle'
      },

      plotOptions: {
          series: {
              pointStart: 2010
          }
      },

      series: [{
          name: 'Installation',
          data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175]
      }, {
          name: 'Manufacturing',
          data: [24916, 24064, 29742, 29851, 32490, 30282, 38121, 40434]
      }, {
          name: 'Sales & Distribution',
          data: [11744, 17722, 16005, 19771, 20185, 24377, 32147, 39387]
      }, {
          name: 'Project Development',
          data: [null, null, 7988, 12169, 15112, 22452, 34400, 34227]
      }, {
          name: 'Other',
          data: [12908, 5948, 8105, 11248, 8989, 11816, 18274, 18111]
      }]
    });    
  };
  
  var refresh = function($tiComponent) {
  };
  
  initialize();
</script>
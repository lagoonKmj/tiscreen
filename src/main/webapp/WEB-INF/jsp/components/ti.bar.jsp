<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="wrap" id="${tiContainerId}"></div>

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
      maxHeight : 8,
      isHighCharts : true
    });
    tiComponentItems[tiComponentId].initialize();
  };
  
  var ready = function() {
    drawChart();
  };
  
  var drawChart = function() {
    var $tiComponent = tiComponentItems["#" + "${tiComponentId}"];
    var divWidth = $tiComponent.getWidth();
    var divHeight = $tiComponent.getHeight();
      Highcharts.chart("${tiContainerId}", {
        chart: {
          type: 'bar',
          width: divWidth,
          height: divHeight,
          backgroundColor: "black"
      },
      title: {
          text: 'Historic World Population by Region',
          style: { "color": "white", "fontSize": "18px" }
      },
      subtitle: {
          text: 'Source: <a href="https://en.wikipedia.org/wiki/World_population">Wikipedia.org</a>'
      },
      xAxis: {
          categories: ['Africa', 'America', 'Asia', 'Europe', 'Oceania'],
          title: {
              text: null
          }
      },
      yAxis: {
          min: 0,
          title: {
              text: 'Population (millions)',
              align: 'high'
          },
          labels: {
              overflow: 'justify'
          }
      },
      tooltip: {
          valueSuffix: ' millions'
      },
      plotOptions: {
          bar: {
              dataLabels: {
                  enabled: true
              }
          }
      },
      legend: {
          layout: 'vertical',
          align: 'right',
          verticalAlign: 'top',
          x: -40,
          y: 80,
          floating: true,
          borderWidth: 1,
          backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
          shadow: true
      },
      credits: {
          enabled: false
      },
      series: [{
          name: 'Year 1800',
          data: [107, 31, 635, 203, 2]
      }, {
          name: 'Year 1900',
          data: [133, 156, 947, 408, 6]
      }, {
          name: 'Year 2012',
          data: [1052, 954, 4250, 740, 38]
      }]
    });
  };
  
  var onResizestop = function($tiComponent) {
    var divWidth = $tiComponent.getWidth();
    var divHeight = $tiComponent.getHeight();
    var chart = $($tiComponent.getTiContainerId()).highcharts();
    chart.setSize(divWidth, divHeight, true);
    chart.reflow();
  };
  
  var refresh = function($tiComponent) {
  };
  
  initialize();
</script>
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
      "minWidth" : 3, 
      "minHeight" : 3, 
      "maxWidth" : 8, 
      "maxHeight" : 8 
    });
    tiComponentItems[tiComponentId].initialize();
  };
  
  var ready = function($tiComponent) {
    drawChart();
  }
  
  var onResize = function($tiComponent) {
    var divWidth = $tiComponent.getWidth();
    var divHeight = $tiComponent.getHeight();
    var chart = $($tiComponent.getTiContainerId()).highcharts();
    chart.setSize(divWidth, divHeight, true);
    chart.reflow();
  }
  
  var drawChart = function() {
    var $tiComponent = tiComponentItems["#" + "${tiComponentId}"];
    var divWidth = $tiComponent.getWidth();
    var divHeight = $tiComponent.getHeight();
    Highcharts.chart("${tiContainerId}", {
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie',
            width: divWidth,
            height: divHeight
        },
        title: {
            text: 'Browser market shares. January, 2015 to May, 2015'
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
                { name: 'IE', y: 56.33 },
                {
                    name: 'Chrome',
                    y: 24.03,
                    sliced: true,
                    selected: true
                },
                { name: 'Firefox', y: 10.38 },
                { name: 'Safari', y: 4.77 }, { name: 'Opera', y: 0.91 },
                { name: 'Proprietary or Undetectable', y: 0.2 }
            ]
        }]
    });    
  };
  
  initialize();
</script>
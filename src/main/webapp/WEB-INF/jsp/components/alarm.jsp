<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
$(function () {

  drawChart();
  
  function drawChart() {
    Highcharts.chart("${divId}", {
      chart: {
          plotBackgroundColor: null,
          plotBorderWidth: 0,
          plotShadow: false
      },
      title: {
          text: 'Browser<br>shares<br>2015',
          align: 'center',
          verticalAlign: 'middle',
          y: 40
      },
      tooltip: {
          pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
      },
      plotOptions: {
          pie: {
              dataLabels: {
                  enabled: true,
                  distance: -50,
                  style: {
                      fontWeight: 'bold',
                      color: 'white'
                  }
              },
              startAngle: -90,
              endAngle: 90,
              center: ['50%', '75%']
          }
      },
      series: [{
          type: 'pie',
          name: 'Browser share',
          innerSize: '50%',
          data: [
              ['Firefox',   10.38],
              ['IE',       56.33],
              ['Chrome', 24.03],
              ['Safari',    4.77],
              ['Opera',     0.91],
              {
                  name: 'Proprietary or Undetectable',
                  y: 0.2,
                  dataLabels: {
                      enabled: false
                  }
              }
          ]
      }]
    });
  };
  
  $(".grid-stack").on("resizestop", function (event, ui) {
    var chart = $("#" + "${divId}").highcharts();
    chart.setSize(1000, 1000, true);
    chart.reflow();
  });
  
});

</script>

<div id="${divId}" style="width: 100%; height: 100%;">
</div>
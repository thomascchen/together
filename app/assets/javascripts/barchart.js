$(function () {
  $.ajax({
    method: 'GET',
    url: '/highcharts',
    dataType: 'json'
  })

  .done(function (users) {
    $('#container-bar').highcharts({
      chart: {
        type: 'column'
      },
      title: {
        text: 'User Contributions'
      },
      subtitle: {
        text: 'Click the columns to view detail.'
      },
      xAxis: {
        type: 'category'
      },
      yAxis: {
        title: {
          text: 'Total percent user contributions'
        }

      },
      legend: {
        enabled: false
      },
      plotOptions: {
        series: {
          borderWidth: 0,
          dataLabels: {
            enabled: true,
            format: '{point.y:.1f}%'
          }
        }
      },

      tooltip: {
        headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
        pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}%</b> of total<br/>'
      },

      series: [{
        name: 'Users',
        colorByPoint: true,
        data: users[1]
      }],

      drilldown: {
        series: users[2]
      }
    });
  });
});

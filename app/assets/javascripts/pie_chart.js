$(function () {
  $.ajax({
    method: 'GET',
    url: '/highcharts',
    dataType: 'json'
  })

  .done(function (problems) {
    $('#container-pie').highcharts({
      chart: {
        plotBackgroundColor: null,
        plotBorderWidth: null,
        plotShadow: false,
        type: 'pie'
      },
      title: {
        text: 'Problems by Type'
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
              color: (
                Highcharts.theme &&
                Highcharts.theme.contrastTextColor
              ) || 'black'
            }
          }
        }
      },
      series: [{
          name: 'Problems',
          colorByPoint: true,
          data: problems[0]
      }]
    });
  });
});

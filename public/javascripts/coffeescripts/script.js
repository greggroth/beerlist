/* DO NOT MODIFY. This file was compiled Fri, 19 Aug 2011 16:36:13 GMT from
 * /Users/Greggory/Programing/beerlist/app/coffeescripts/script.coffee
 */

(function() {
  $(document).ready(function() {
    $('#no-script').remove();
    $('.itemlist tbody tr:nth-child(odd)').addClass('zebra');
    $('#user_bar a').hover(function() {
      $(this).animate({
        paddingBottom: '+=15px'
      }, 200);
    }, function() {
      $(this).animate({
        paddingBottom: '-=15px'
      }, 200);
    });
    /* Generate Charts for /bar_owner */
    $('div.chart').each(function() {
      return $.jqplot($(this).attr('id'), [$(this).metadata().chartdata], {
        title: 'Followers',
        axes: {
          xaxis: {
            renderer: $.jqplot.DateAxisRenderer
          }
        },
        series: [
          {
            lineWidth: 4,
            showMarker: false
          }
        ]
      });
    });
    /*  Expanding Itemlist */
    $('.expandable_itemlist, .chart_list').find("tr:odd").addClass("odd").hover(function(e) {
      return $(e.target).closest('tr').toggleClass("active");
    });
    $('.expandable_itemlist, .chart_list').find("tbody tr:nth-child(4n+1)").addClass('zebra');
    $('.expandable_itemlist, .chart_list').find("tr:not(.odd)").hide();
    $('.expandable_itemlist, .chart_list').find("tr:first-child").show();
    $('.expandable_itemlist, .chart_list').find('a').click(function(e) {
      return $(e.target).stopPropagation();
    });
    $('.expandable_itemlist').find('tr.odd').click(function(e) {
      $(e.target).closest('tr').next('tr').toggle();
      if ($(e.target).closest('tr').next('tr').is(':visible')) {
        return $('#itemdesc-' + $(e.target).closest('tr').attr('id')).children('div').css('border', 'solid thin #E8E8E8').html('loading...').load($(e.target).closest('tr').attr('item_url') + ' .itemlist').show();
      }
    });
    return $('.chart_list').find('tr.odd').click(function() {
      return $(this).next('tr').toggle($(this).find('.arrow').toggleClass('up'));
    });
  });
  return;
}).call(this);

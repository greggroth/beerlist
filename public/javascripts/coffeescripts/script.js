/* DO NOT MODIFY. This file was compiled Sat, 03 Sep 2011 19:22:09 GMT from
 * /Users/Greggory/Programing/beerlist/app/coffeescripts/script.coffee
 */

(function() {
  $(document).ready(function() {
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
    $('.expandable_itemlist').find('tr:odd').addClass('odd').hover(function(e) {
      return $(e.target).closest('tr').toggleClass("active");
    });
    $('.manager_list:not(.beeritems)').find('tr:nth-child(3n+1)').addClass('odd').hover(function(e) {
      return $(e.target).closest('tr').toggleClass("active");
    });
    $('.expandable_itemlist').find('tbody tr:nth-child(4n+1)').addClass('zebra');
    $('.manager_list').find('tbody tr.heading:odd').addClass('zebra');
    $('.expandable_itemlist, .manager_list').find('tr:not(.odd)').hide();
    $('.expandable_itemlist, .manager_list').find('tr:first-child').show();
    $('.expandable_itemlist, .manager_list').find('a').click(function(e) {
      return e.stopPropagation();
    });
    $('.expandable_itemlist, .manager_list').find('div.follow_form').click(function(e) {
      return e.stopPropagation();
    });
    $('.expandable_itemlist').find('tr.odd').click(function(e) {
      $(e.target).closest('tr').next('tr').toggle();
      if ($(e.target).closest('tr').next('tr').is(':visible')) {
        return $('#itemdesc-' + $(e.target).closest('tr').attr('id')).children('div').css('border', 'solid thin #E8E8E8').html('loading...').load($(e.target).closest('tr').attr('item_url') + ' .itemlist').show();
      }
    });
    /*  Expanding Chartlist (some things are also handled in the above secion)  */
    $('.manager_list').find('tr.odd').click(function() {
      return $(this).nextAll('tr.chart:first, tr.beeritems:first').toggle($(this).find('.arrow').toggleClass('up'));
    });
    /*  Detail/Edit Links visible on hover */
    $('a.action_link').hide();
    $('tr').hover(function() {
      return $(this).find('a.action_link').toggle();
    });
    /*  Up/Down sort arrows */
    return $('#sorted_beer_item_list a').click(function() {
      return $(this).parent('th').find('.arrow').toggleClass('asc current');
    });
  });
  return;
}).call(this);

/* DO NOT MODIFY. This file was compiled Fri, 23 Sep 2011 21:03:24 GMT from
 * /Users/Greggory/Programing/beerlist/app/assets/javascripts/script.coffee
 */

(function() {
  window.Application || (window.Application = {});
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
    /*  Manager_list */
    $('.manager_list:not(.beeritems)').find('tr:nth-child(3n+1)').addClass('odd').hover(function(e) {
      return $(e.target).closest('tr').toggleClass("active");
    });
    $('.manager_list').find('tbody tr.heading:odd').addClass('zebra');
    $('.manager_list').find('tr:not(.odd)').hide();
    $('.manager_list').find('tr:first-child').show();
    $('.manager_list').find('a').click(function(e) {
      return e.stopPropagation();
    });
    $('.manager_list').find('div.follow_form').click(function(e) {
      return e.stopPropagation();
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
    $('#sorted_beer_item_list a').click(function() {
      return $(this).parent('th').find('.arrow').toggleClass('asc current');
    });
    /*  format expanding itemlist function */
    Application.format_expandable_itemlist('.expandable_itemlist');
    /*  add notice for beer_item edit */
    $('#beer_item_pouring_notice').hide();
    $('#beer_item_pouring').change(function() {
      if ($(this).val() === 'pitcher') {
        return $('#beer_item_pouring_notice').show();
      } else {
        return $('#beer_item_pouring_notice').hideide();
      }
    });
    /*  Show/Hide Google Map              */
    $('#toggle-map-link a').click(function() {
      return $('#gmap_popup_panel').css({
        'z-index': '1'
      });
    });
    $('#gmap_popup_panel_close').click(function() {
      return $('#gmap_popup_panel').css({
        'z-index': '-1'
      });
    });
    /* $('#gmap_popup_panel_close').qtip({
    		content: 'Close'
    		position: {
    			my: 'left center'
    			at: 'right center'
    			target: $('#gmap_popup_panel_close')
    		}
    		style: {
    		      classes: 'ui-tooltip-blue ui-tooltip-tipsy'
    				}
    	}) */
    /*  Sorting Options */
    $('#adv-searching').hide();
    $('#adv-searching-button').click(function() {
      return $('div#adv-searching').toggle('blind');
    });
    $('#reset_search').click(function(e) {
      return e.stopPropagation();
    });
    /* qtip for abd */
    $('.abd-table-heading').qtip({
      content: 'Alcohol by Dollar.  Similar to abv except this also takes into account the price and volume to indicate what the best deals are.  The higher the number, the more alcohol you get for your money.',
      position: {
        my: 'bottom left',
        at: 'top right',
        target: 'mouse',
        adjust: {
          x: 10,
          y: -10
        }
      },
      style: {
        classes: 'ui-tooltip-light ui-tooltip-shadow'
      }
    });
  });
  Application.format_expandable_itemlist = function(x) {
    /*  Expandable Itemlist */    $(x).find('tr:odd').addClass('odd').hover(function(e) {
      $(e.target).closest('tr').toggleClass("active");
      return $(e.target).closest('tr').find('a.action_link').toggle();
    });
    $(x).find('tbody tr:nth-child(4n+1)').addClass('zebra');
    $(x).find('tr:not(.odd)').hide();
    $(x).find('tr:first-child').show();
    $(x).find('a').click(function(e) {
      return e.stopPropagation();
    });
    $(x).find('div.follow_form').click(function(e) {
      return e.stopPropagation();
    });
    $(x).find('tr.odd').click(function() {
      $(this).closest('tr').next('tr').toggle();
      console.log($(this).closest('tr').next('tr').find('div.itemlist').size());
      if ($(this).closest('tr').next('tr').is(':visible')) {
        if ($(this).closest('tr').next('tr').find('div.itemlist').size() === 0) {
          return $('#itemdesc-' + $(this).closest('tr').attr('id')).children('div').css({
            'border': 'solid thin #E8E8E8',
            'border-radius': '10px',
            'padding-left': '5px'
          }).html('loading...').load($(this).closest('tr').attr('item_url') + ' .itemlist');
        }
      }
    });
  };
}).call(this);

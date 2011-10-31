/* DO NOT MODIFY. This file was compiled Fri, 28 Oct 2011 19:37:25 GMT from
 * /Users/Greggory/Programing/beerlist/app/assets/javascripts/script.coffee
 */

(function() {
  window.Application || (window.Application = {});
  /* Test If Updates script.js */
  $(document).ready(function() {
    var reformat_profile_beer_items_container;
    Application.format_normal_itemlist('.itemlist');
    $('div#new-beer-from-beer-item').hide();
    $('select#beer_item_beer_id').prepend('<option value="new">New Beer</option>').change(function() {
      return $('div#new-beer-from-beer-item').toggle();
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
    /*  Expanding Chartlist (some things are also handled in the above secion)  */
    $('.manager_list').find('tr.odd').click(function() {
      return $(this).nextAll('tr.chart:first, tr.beeritems:first').toggle($(this).find('.arrow').toggleClass('up'));
    });
    /*  Detail/Edit Links visible on hover */
    $('a.action_link').hide();
    $('tbody.with-action-links > tr').live('hover', function() {
      return $(this).find('a.action_link').toggle();
      /*
      		$(this).toggleClass("active")
      		*/
    });
    /*  Up/Down sort arrows */
    $('#sorted_beer_item_list a').click(function() {
      return $(this).parent('th').find('.arrow').toggleClass('asc current');
    });
    /*  format expanding itemlist function */
    Application.format_expandable_itemlist('.expandable_itemlist');
    /*  add notice for beer_item edit */
    $('div#pitcher').hide();
    $('span#bucket').hide();
    $('#beer_item_pouring').change(function() {
      $('div#pitcher').hide();
      $('span#bucket').hide();
      if ($(this).val() === 'pitcher') {
        return $('div#pitcher').show();
      } else if ($(this).val() === 'bucket') {
        return $('span#bucket').show();
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
    $('.abd-table-heading, .abd-info-needed').qtip({
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
    reformat_profile_beer_items_container = function(x) {
      $(x).find('tbody:not(#main-body) tr:nth-child(odd)').addClass('zebra');
      $('a.action_link').hide();
    };
    /* preview for beer_items on the profiles page */
    $('table#beer-item-preview tbody tr:nth-child(4n+1)').addClass('zebra');
    $('table#beer-item-preview tbody tr:odd').hide();
    $('table#beer-item-preview').find('a').click(function(e) {
      return e.stopPropagation();
    });
    $('table#beer-item-preview tbody > tr').live('click', function() {
      var row, targetRow, url;
      row = $(this);
      if (row.next('tr').is(':visible')) {
        return row.next('tr').hide();
      } else {
        url = row.attr('data-url') + ' #beer-item-list';
        targetRow = 'tr#beer-item-details-container-' + row.attr('data-id');
        $(targetRow).show();
        return $(targetRow + ' td div').css({
          'border': 'solid thin #E8E8E8',
          'border-radius': '10px',
          'padding-left': '5px'
        }).html('loading...').load(url, function() {
          return reformat_profile_beer_items_container('.itemlist');
        });
      }
    });
  });
  Application.format_expandable_itemlist = function(x) {
    /*  Expandable Itemlist */    $(x).find('tr:odd').addClass('odd').hover(function(e) {
      return $(e.target).closest('tr').toggleClass("active")($(e.target).closest('tr').find('a.action_link').toggle());
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
      if ($(this).closest('tr').next('tr').is(':visible')) {
        if ($(this).closest('tr').next('tr').find('div.itemlist').size() === 0) {
          return $('#itemdesc-' + $(this).closest('tr').attr('id')).children('div').css({
            'border': 'solid thin #E8E8E8',
            'border-radius': '10px',
            'padding-left': '5px'
          }).html('loading...').load($(this).closest('tr').attr('data-item-url') + ' .itemlist', function() {
            return Application.reformat_bars_page('.itemlist');
          });
        }
      }
    });
    return false;
  };
  Application.format_normal_itemlist = function(x) {
    $(x).find('tbody tr:nth-child(odd)').addClass('zebra');
  };
  Application.reformat_bars_page = function(x) {
    $(x).find('tbody tr:nth-child(odd)').addClass('zebra');
    $('a.action_link').hide();
  };
}).call(this);

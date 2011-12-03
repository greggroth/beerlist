/* DO NOT MODIFY. This file was compiled Sat, 03 Dec 2011 14:43:58 GMT from
 * /Users/Greggory/Programing/beerlist/app/assets/javascripts/bars.coffee
 */

(function() {
  $(document).ready(function() {
    $.getJSON('/beer_tracks', function(data) {
      return $('.beer_tracking_checkbox').each(function(index) {
        if ($.inArray(parseInt($(this).attr('data-beer')), data) !== -1) {
          return $(this).attr("checked", "checked");
        }
      });
    });
    $('form.rating_ballot').each(function() {
      var checkedId;
      checkedId = $(this).children('input:checked').attr('id');
      return $(this).children('label[for=' + checkedId + ']').prevAll().andSelf().addClass('bright');
    });
    $('form.rating_ballot > label').live('hover', function(e) {
      if (e.type === "mouseenter") {
        return $(this).prevAll().andSelf().addClass('glow');
      } else {
        return $(this).siblings().andSelf().removeClass('glow');
      }
    });
    $('form.rating_ballot > label').live('click', function() {
      $(this).siblings().removeClass("bright");
      return $(this).prevAll().andSelf().addClass("bright");
    });
    $('a#close-popup').live('click', function() {
      return $('div#rating-popup-container').empty();
    });
    $('form.rating_ballot').live('change', function() {
      return $(this).submit();
    });
    $('.beer_tracking_checkbox').live('change', function(e) {
      var bar, beer, token;
      bar = $(e.target).attr('data-bar');
      beer = $(e.target).attr('data-beer');
      token = $('meta[name=csrf-token]').attr('content');
      return $.post('/beer_tracks', {
        "authenticity_token": token,
        "beer_track": {
          "bar_id": bar,
          "beer_id": beer
        }
      });
    });
  });
}).call(this);

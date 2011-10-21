/* DO NOT MODIFY. This file was compiled Fri, 21 Oct 2011 18:05:34 GMT from
 * /Users/Greggory/Programing/beerlist/app/assets/javascripts/rating_ballot.coffee
 */

(function() {
  $(document).ready(function() {
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
  });
}).call(this);

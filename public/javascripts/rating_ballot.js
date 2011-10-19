/* DO NOT MODIFY. This file was compiled Wed, 19 Oct 2011 04:21:05 GMT from
 * /Users/Greggory/Programing/beerlist/app/assets/javascripts/rating_ballot.coffee
 */

(function() {
  $('form.rating_ballot').each(function() {
    var checkedId;
    checkedId = $(this).children('input:checked').attr('id');
    return $(this).children('label[for=' + checkedId + ']').prevAll().andSelf().addClass('bright');
  });
  $(document).ready(function() {
    $('form.rating_ballot > label').hover((function() {
      return $(this).prevAll().andSelf().addClass('glow');
    }), (function() {
      return $(this).siblings().andSelf().removeClass('glow');
    }));
    $('form.rating_ballot > label').click(function() {
      $(this).siblings().removeClass("bright");
      return $(this).prevAll().andSelf().addClass("bright");
    });
    $('form.rating_ballot').change(function() {
      return console.log($(this));
    });
    $(this).submit();
  });
}).call(this);

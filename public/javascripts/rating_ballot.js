/* DO NOT MODIFY. This file was compiled Tue, 18 Oct 2011 19:05:39 GMT from
 * /Users/Greggory/Programing/beerlist/app/assets/javascripts/rating_ballot.coffee
 */

(function() {
  $(function() {
    var checkedId;
    checkedId = $('form.rating_ballot > input:checked').attr('id');
    $('form.rating_ballot > label[for=' + checkedId + ']').prevAll().andSelf().addClass('bright');
    return console.log(checkedId);
  });
  $(document).ready(function() {
    $('form.rating_ballot > label').hover((function() {
      return $(this).prevAll().andSelf().addClass('glow');
    }), (function() {
      return $(this).siblings().andSelf().removeClass('glow');
    }));
    $('form.rating_ballot > label').click(function() {
      return $(this).siblings().removeClass("bright")($(this).prevAll().andSelf().addClass("bright"));
    });
    return $('form.rating_ballot').change(function() {
      return $('form.rating_ballot').submit();
    });
  });
}).call(this);

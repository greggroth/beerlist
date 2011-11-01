/* DO NOT MODIFY. This file was compiled Tue, 01 Nov 2011 19:20:24 GMT from
 * /Users/Greggory/Programing/beerlist/app/assets/javascripts/beer_items.js.coffee
 */

(function() {
  $(document).ready(function() {
    $('div#new-beer-from-beer-item').hide();
    return $('select#beer_item_beer_id').prepend('<option value="new">New Beer</option>').change(function() {
      return $('div#new-beer-from-beer-item').toggle();
    });
  });
}).call(this);

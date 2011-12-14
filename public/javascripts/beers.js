/* DO NOT MODIFY. This file was compiled Wed, 14 Dec 2011 17:13:19 GMT from
 * /Users/Greggory/Programing/beerlist/app/assets/javascripts/beers.coffee
 */


  $(document).ready(function() {
    return $('#beer_tracker > a').click(function() {
      console.log("Clicked");
      return $('#beer_tracker').html("You've had it!");
    });
  });

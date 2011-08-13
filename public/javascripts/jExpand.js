(function($){
    $.fn.jExpand = function(){
        var element = this;
		
        $(element).find("tr:odd").addClass("odd");
        $(element).find("tbody tr:nth-child(4n+1)").addClass('zebra');
        $(element).find("tr:not(.odd)").hide();
        $(element).find("tr:first-child").show();

		$(element).find("tr.odd").hover(function() {
			$(this).toggleClass("active")
		});
		
		$(element).find('a').click(function(e) {
			e.stopPropagation()
			});

        $(element).find("tr.odd").click(function() {
        	var url = $(this).attr('title') + " .itemlist";
        	var item_id = "#itemdesc-" + $(this).attr('id');
        	
        	$(this).next("tr").toggle();
        	
        	if ($(this).next("tr").is(":visible")) {
        		$(item_id).children('p').hide().css('border','solid thin #E8E8E8').html('loading...').load(url).show();
        	};
        });
        
    }    
})(jQuery); 
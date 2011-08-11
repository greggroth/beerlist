(function($){
    $.fn.jExpand = function(){
        var element = this;
		
        $(element).find("tr:odd").addClass("odd");
        $(element).find("tbody tr:nth-child(4n+1)").addClass('zebra');
        $(element).find("tr:not(.odd)").hide();
        $(element).find("tr:first-child").show();

        $(element).find("tr.odd").click(function() {
        	var url = $(this).attr('title') + " .itemlist";
        	var item_id = "#itemdesc-" + $(this).attr('id');
        	
        	        	$(this).next("tr").toggle();
        	
        	if ($(this).next("tr").is(":visible")) {
        		$(item_id).children('p').hide().html('loading...').load(url).slideDown();
        	};
        });
        
    }    
})(jQuery); 
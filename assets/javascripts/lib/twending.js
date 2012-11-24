/* ==================================================
 * T W E N D I N G   C L A S S
 * Main application class
 * By: Jason Howmans // www.jase.in // 18 Nov 2012
 * ================================================== */
var Twending = {

	/* Options
 	* =============================================== */
	options: {
		WOEID: 				44418,
		story_container: 	$('ul.articles-list')
	},


	/* Initialiser function
 	* =============================================== */
	init: function(options) {
		var o = $.extend({}, this.options, options);

		o.story_container.each( function() {
			var trend 	= $(this).attr('data-trend'),
			story_block	= $(this);

			// Make request to stream for some stories
			$.get('stream/story', { search: trend }, function(result) {
				var data_obj	= JSON.parse(result);
				var stories		= data_obj.response.results || false;

				if (stories) {
					var append_data = "";
					console.log(trend, stories);
					_.each(stories, function(story) {
						console.log("-> "+story.webTitle);
						append_data = append_data + '<li><h3><a href="'+story.webUrl+'" target="_blank">'+story.webTitle+'</a></h3></li>';
					});
					// Push to page & remove loading
					if ($('.im_loading', story_block).length) $('.im_loading', story_block).remove();
					story_block.append(append_data);
				}
			});
		});
	}

};
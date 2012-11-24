require "open-uri"
require "uri"
# ==================================================
# S T R E A M  >>  T W E N D I N G
# ==================================================
module Twending
	class Stream < Sinatra::Base


		# Config
    	# ==============================================
    	configure do
    	end

		before do
			@guardian_uri = 'http://content.guardianapis.com'
		end

		# Get news items based on querystring
		# ==============================================
		get '/story' do
			refinement 		= 2
			search_query 	= params[:search] || 'Space'
			search_query 	= URI.escape(search_query)	
			open("#{@guardian_uri}/search?q=#{search_query}&order-by=relevance&format=json&refinement-size=#{refinement}&date-id=date%2Flast7days&api-key=#{CONFIG['guardian']['api_key']}")
		end

	end
end
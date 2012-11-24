# ==================================================
# A P P  >>  T W E N D I N G
# ==================================================
module Twending
  class App < Sinatra::Base

    # Helper methods
    # ==============================================
    helpers do

    end

    # Config
    # ==============================================
    configure do
      set :root, File.join( File.dirname(__FILE__), '..' )
      set :sessions, true
      set :session_secret, 'TwEnDiNg'
      set :views, File.join( File.dirname(__FILE__), '..', 'views' )
      set :public, Proc.new { File.join("assets") }
      set :static, true
    end  

    before do
      @client = Twitter::Client.new(
        :consumer_key => CONFIG['twitter']['consumer_key'],
        :consumer_secret => CONFIG['twitter']['consumer_secret'],
        :oauth_token => CONFIG['twitter']['oauth_token'],
        :oauth_token_secret => CONFIG['twitter']['oauth_token_secret']
        )
    end

    # Front page
    # ===============================================
    get "/front" do
      @title = "Front page"
      unless session[:trends]
        @trends = @client.trends('44418')
        session[:trends] = @trends
      else
        @trends = session[:trends]
      end
      erb :front
    end

    # Start page
    # ===============================================
    get '/' do
      redirect '/front'
    end
    
    def self.new(*)
      super
    end
    
  end
end

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
        :consumer_key => "zB93XCuq08r3xJqJ1T8vw",
        :consumer_secret => "FZ7HuRBDAzLidL91vQpdyr7a1cQZ55PNIEMGJFBloo",
        :oauth_token => "20256024-NRZOI4e1lFZS6XJdvFeeoNDmavEv8lL9dTEZ0qTv0",
        :oauth_token_secret => "ic4oTyYY6hv5ZoxgU5zn10PzMm7XIvsWNuuEbFiTCbw"
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
      
    end
    
    def self.new(*)
      super
    end
    
  end
end

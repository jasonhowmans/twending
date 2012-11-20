# ==================================================
# A P P  >>  T W E N D I N G
# ==================================================
module Twending
  class App < Sinatra::Base
    # Helper methods
    # ==============================================
    helpers do
      def auth_user?
        @auth_user ||= session[:twitter_user] if session[:twitter_user]
      end

      def prepare_access_token(oauth_token, oauth_token_secret)
        consumer = OAuth::Consumer.new("zB93XCuq08r3xJqJ1T8vw", "FZ7HuRBDAzLidL91vQpdyr7a1cQZ55PNIEMGJFBloo", { :site => "http://api.twitter.com" })
        token_hash = { :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret }
        access_token = OAuth::AccessToken.from_hash(consumer, token_hash)
        return access_token
      end

      def twitter
        @tw_user ||= prepare_access_token(session[:twitter_user][:token], session[:twitter_user][:secret])
      end
    end

    before '/^(?!\/(front|login|logout))/' do
      unless auth_user?
        redirect "/login"
      end
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

    use OmniAuth::Builder do
      provider :twitter, 'zB93XCuq08r3xJqJ1T8vw', 'FZ7HuRBDAzLidL91vQpdyr7a1cQZ55PNIEMGJFBloo' # Twitter strategy
    end

    # Redirect after authorisation
    # ===============================================
    get '/auth/:name/callback' do
      auth = request.env['omniauth.auth']
      user_data = { :uid => auth["uid"],
                    :token => auth['oauth_token_secret'],
                    :secret => auth['oauth_token'],
                    :nickname => auth["info"]["nickname"], 
                    :name => auth["info"]["name"],
                    :created_at => Time.now }
      session[:twitter_user] = user_data
      session[:user_id] = auth["uid"]
      redirect "/"
    end
    
    # Multiple routes to login / out
    # ===============================================
    ["/sign_in/?", "/signin/?", "/log_in/?", "/login/?", "/sign_up/?", "/signup/?"].each do |path|
      get path do
        redirect '/auth/twitter'
      end
    end

    ["/sign_out/?", "/signout/?", "/log_out/?", "/logout/?"].each do |path|
      get path do
        session[:user_id] = nil
        redirect '/'
      end
    end  

    # Front page
    # ===============================================
    get "/front" do
      if auth_user?
        puts twitter.request(:post, "http://api.twitter.com/1/statuses/update.json", :status => "Hello")


        @title = session[:twitter_user][:name]
        erb :front
      else
        @title = "Please login"
        erb :login
      end
    end

    # Start page
    # ===============================================
    get '/' do
      if auth_user? 
        redirect "/front"
      else
        redirect "/login"
      end
    end
    
    def self.new(*)
      super
    end
    
  end
end

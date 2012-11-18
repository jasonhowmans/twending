# ==================================================
# S T R E A M  >>  T W E N D I N G
# ==================================================
module Twending
  class Stream < Sinatra::Base

    # Helper methods
    # ==============================================
    helpers do
      def auth_user?
        @auth_user ||= session[:user_id] if session[:user_id]
      end
    end

    # Config
    # ==============================================
    configure do
      set :sessions, true
      set :session_secret, 'TwEnDiNg'
    end

    before do
      unless auth_user?
        halt 401, "Authentication error!"
      end
    end

    get '/hello' do
      "Hello, #{session[:user_id]}"
    end

    def self.new(*)
      super
    end
    
  end
end

# ==================================================
# 
# ==================================================
module Twending
  class App < Sinatra::Base
    
    # Config
    # ==================================================
    configure do
      set :views, File.join( File.dirname(__FILE__), '..', 'views' )
    end
    
   # Front page route
   # ==================================================
    get '/' do
      
    end  
    
    def self.new(*)
      super
    end
    
  end
end

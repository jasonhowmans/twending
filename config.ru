require File.dirname(__FILE__) + '/config/boot.rb'

require 'omniauth'
require 'omniauth-twitter'

run Rack::URLMap.new({
	"/" => Twending::App,
	"/stream" => Twending::Stream
})

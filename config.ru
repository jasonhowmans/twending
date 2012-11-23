require File.dirname(__FILE__) + '/config/boot.rb'

require 'twitter'

run Rack::URLMap.new({
	"/" => Twending::App
})

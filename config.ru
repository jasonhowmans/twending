require File.dirname(__FILE__) + '/config/boot.rb'

require 'yaml'
require 'twitter'

# Import configuration from config/ure.yml
CONFIG = YAML.load_file('config/ure.yml') unless defined? CONFIG

run Rack::URLMap.new({
	"/" => Twending::App,
	"/stream" => Twending::Stream
})

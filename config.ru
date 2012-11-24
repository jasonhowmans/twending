require File.dirname(__FILE__) + '/config/boot.rb'

require 'yaml'
require 'twitter'

# Import configuration from config/ure.yml
CONFIG = Yaml.load_file('config/ure.yaml') unless defined? CONFIG

run Rack::URLMap.new({
	"/" => Twending::App
})

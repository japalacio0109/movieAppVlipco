$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'api'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'
Bundler.require :default, ENV['RACK_ENV']
require 'database'

Dir[File.expand_path('../../lib/**/**/*.rb', __FILE__)].each do |f|
  require f
end

Dir[File.expand_path('../../api/**/**/*.rb', __FILE__)].each do |f|
  require f
end
require 'api_base'
require 'app_base'


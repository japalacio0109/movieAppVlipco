require File.expand_path('../config/environment', __FILE__)

if ENV['RACK_ENV'] == 'development'
  puts 'Starting server in developer mode...'

end


run MovieApp::App.instance
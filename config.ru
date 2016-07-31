require 'rubygems' unless defined? ::Gem
require File.dirname( __FILE__ ) + '/app.rb'

run Sinatra::Application

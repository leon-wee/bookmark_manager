require 'rubygems'
require File.join(File.dirname(__FILE__), 'app/app.rb')
require_relative 'app/app'
run Sinatra::Application

run BookmarkManager
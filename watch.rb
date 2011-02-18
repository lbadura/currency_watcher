$:.unshift File.dirname(__FILE__)
require 'sinatra'
require 'erb'
require 'ruby-debug'
require 'lib/helpers'

include CurrencyWatcher::Helpers

set :public, Proc.new { File.join(root, "public") }
set :views, Proc.new { File.join(root, "templates") }

get '/' do
  erb :index, :layout => :application
end

get '/o' do
  erb :about, :layout => :application
end

get '/ryzyko' do
  erb :risk, :layout => :application
end

get '/spread' do
  erb :spread, :layout => :application
end

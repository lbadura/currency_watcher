require 'sinatra'
require 'erb'

set :public, Proc.new { File.join(root, "public") }
set :views, Proc.new { File.join(root, "templates") }

get '/' do
  erb :index
end

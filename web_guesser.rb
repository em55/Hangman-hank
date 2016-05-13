require 'sinatra'
require 'sinatra/reloader'


x = rand(100)

get '/' do
	erb :index, :locals => {:x => x}
	
end
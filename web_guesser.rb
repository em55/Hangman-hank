require 'sinatra'
require 'sinatra/reloader'

get '/' do
	x = rand(100)
	"THE SECRET NUMBER IS #{x}"
end
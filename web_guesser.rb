require 'sinatra'
require 'sinatra/reloader'


x = rand(100)
		
def check_guess(n,g)
	
	diff = n - g
	if diff == 0
			return "You got it right! <br> The secret number is #{n}" 
	elsif diff > 5
			return "Way too low!"
	elsif diff <= 5
			return "Too low!"
	elsif diff < -5
			return "Way too high!"
	elsif diff >= -5
			return "Too high!"
									
	end
end


get '/' do
	
	guess = params['guess'].to_i

	
	m = check_guess(x,guess)

	erb :index, :locals => {:x => x, :m => m}

	
end



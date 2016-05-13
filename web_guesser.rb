require 'sinatra'
require 'sinatra/reloader'


x = rand(100)

		
get '/' do
	
	guess = params['guess'].to_i
	m = check_guess(x,guess)
	erb :index, :locals => {:x => x, :m => m}

end

def check_guess(n,g)
	
	diff = g - n
	if diff == 0
			
			return "<style> body { background: green;} </style> 
					You got it right! <br> The secret number is #{n}" 
	elsif diff < -5
			
			return "<style> body { background: red;} </style>
					Way too low!"
	elsif diff > 5
			return "<style> body { background: red;} </style>
					Way too high!"
	elsif (diff > 0 && diff <=5)
			return "<style> body { background: pink; color: black;} </style>
					Too high!"
	elsif (diff < 0 && diff >= -5)
			
			return "<style> body { background: pink; color: black;} </style>
					Too low!"
	
									
	end
end




require 'sinatra'
require 'sinatra/reloader'


@@x = rand(100)
@@guess_count = 5

get '/' do
	
	guess = params['guess'].to_i
	m = check_guess(@@x,guess)
	x = @@x
	erb :index, :locals => {:x => x, :m => m}

end

def check_guess(n,g)
	
	diff = g - n
	@@guess_count -= 1
	if(@@guess_count > 0)
		if diff == 0
			@@guess_count = 5
			@@x = rand(100)
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

	elsif (@@guess_count == 0 && diff !=0)
		@@guess_count = 5
		@@x = rand(100)
		return "You have lost :(  <br> But, don't ya worry =D <br> A new number has been generated - Try again!"
	end

end




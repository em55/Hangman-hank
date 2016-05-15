require 'sinatra'
require 'sinatra/reloader' 


set :port, 8080

@@guess_count = 5
@@dash = []

get '/' do

	erb :index
end

post '/' do 
	@@level = params['level'].to_i + 1
	@@word = get_word(@@level).split " "
	@@dash = Array.new(@@level, '____  ')
	word = @@word
	dash = @@dash
	g = @@guess_count
	m = "Yo! B)"
	erb :game, :locals => {:g => g, :m => m, :dash => dash, :word => word}
end

get '/game/' do
	
	@@letter = params['letter']
	
	m, g, dash = check_guess(@@letter)
	
	word = @@word
	erb :game, :locals => {:g => g, :m => m, :dash => dash, :word => word}

end

helpers do
	def get_word(len)

		f = File.open("enable.txt")
		line = f.readline.chomp
		while (line && !f.eof?) do
			
				if(line.size.eql?(len))	
					return line
		
				else
					x = rand(172823)
					f.pos = x
					line = f.readline

				end
			
		end
		f.close
	end

	def check_guess(l)
			
		while @@dash.include? "____  " do
			if @@guess_count == 1
				@@guess_count = 5
				return "You have lost! :(  <br> But, don't ya worry =D 
					<br> Try again!", 0, @@dash
			else
		
				if  @@word.include? l
					@@guess_count -= 1
					i = @@word.each_index.select{|i| @@word[i] == l}
					i.each do |a|
						@@dash[a] = @@word[a]
					end
					return "Good job! Keep going!",@@guess_count, @@dash
					#p dash.join
					#p "Guesses: #{guess}"

				else
					@@guess_count -= 1
					return "Its alright, keep going!", @@guess_count, @@dash
					#p "Guesses: #{guess}"
				end
			end
		end	

		if !@@dash.include? "____  "
			@@guess_count = 5
			return "<style> body { background: green;} </style> 
						You got it right! <br> The word is #{@@word}
						<br>A new word has been generated - Play again!", @@guess_count, @@dash
		end

	end
end



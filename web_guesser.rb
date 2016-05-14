require 'sinatra'
require 'sinatra/reloader' 

@@guess_count = 5

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
	m = "Yo B)"
	erb :game, :locals => {:g => g, :m => m, :dash => dash, :word => word}
end

get '/game' do

	@@letter = params['letter']
	m = check_guess(@@letter)
	g = @@guess_count
	erb :game, :locals => {:g => g, :m => m, :dash => dash, :word => word}
end

post '/game' do

	@@letter = params['letter']
	m = check_guess(@@letter)
	g = @@guess_count
	erb :game, :locals => {:g => g, :m => m, :dash => dash, :word => word}
end

def get_word(len)

	f = File.open("enable.txt")
	line = f.readline
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
		
	while dash.include? "____  " do
		if @@guess_count == 0
			return "You have lost :(  <br> But, don't ya worry =D 
				<br> A new word has been generated - Try again!"
		else
	
			if  word.include? l
				@@guess_count -= 1
				i = word.each_index.select{|i| word[i] == l}
				i.each do |a|
					dash[a] = word[a]
				end
				#p dash.join
				#p "Guesses: #{guess}"

			else
				@@guess_count -= 1
				#p "Guesses: #{guess}"
			end
		end
	end	

	if !dash.include? "____  "
		return "<style> body { background: green;} </style> 
					You got it right! <br> The secret number is #{n}
					<br>A new word has been generated - Play again!"
	end

end




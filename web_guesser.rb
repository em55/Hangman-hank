require 'sinatra'
require 'sinatra/reloader' 

@@guess = 5
@@dash = []
@@m_guess = []

get '/' do
	@@guess = 5
	@@m_guess = []
	erb :index
end

post '/' do 
	@@level = params['level'].to_i + 1
	@@word = get_word(@@level).split ""
	@@dash = Array.new(@@level-1, '____  ')
	redirect '/game/'
end

get '/game/' do
	

	g, m, d, m_guess, word = @@guess, "", @@dash.join, @@m_guess, @@word

	erb :game, :locals => {:g => g, :m => m, :d => d, :word => word, :m_guess => m_guess}
end

post '/game/' do
	
	@@letter = params['letter']
	l = @@letter				
	
	if @@guess == 1
		m = "You have lost"
		if !@@word.include? l
			@@m_guess.insert(@@m_guess.length, l) 
		else
			i = @@word.each_index.select{|i| @@word[i] == l}
				i.each do |a|
					@@dash[a] = l
				end
		end
		d = @@dash.join
		word = @@word
		g = @@guess
		m_guess = @@m_guess
	else
		if  @@word.include? l
			if @@dash.include? l
				m = "You've already tried this letter. Try a different one!"
				d = @@dash.join
				g = @@guess
				m_guess = @@m_guess
				word = @@word
			else
				@@guess = @@guess - 1
				i = @@word.each_index.select{|i| @@word[i] == l}
				i.each do |a|
					@@dash[a] = l
				end
				m = "Good job! Keep going!"
				d = @@dash.join
				g = @@guess
				m_guess = @@m_guess
				word = @@word
			end
		else
			if @@m_guess.include? l
				m = "You've already tried this letter. Try a different one!"
				d = @@dash.join
				g = @@guess
				m_guess = @@m_guess
				word = @@word
			else
				@@m_guess.insert(@@m_guess.length, l)
				@@guess = @@guess - 1
				m = "Its alright, keep going!"
				d = @@dash.join
				g = @@guess
				word = @@word
				m_guess = @@m_guess
			end
		end
	end
	

	if !@@dash.include? "____  "
		m = "You have won!"
		word = @@word
	end

	erb :game, :locals => {:g => g, :m => m, :d => d, :word => word, :m_guess => m_guess}
end

helpers do
	def get_word(len)

		arr = []
		File.open("enable.txt").readlines.each_with_index do |line|
		
			if(line.size.eql?(len))	
				arr.insert(arr.length,line)
			end
		end

	return arr[rand(arr.length)]
	end
end



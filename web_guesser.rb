require 'sinatra'
require 'sinatra/reloader' 


set :port, 8080

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
	

	g, m, d, m_guess, word = @@guess, "start", @@dash.join, @@m_guess, @@word

	erb :game, :locals => {:g => g, :m => m, :d => d, :word => word, :m_guess => m_guess}
end

post '/game/' do
	
	@@letter = params['letter']
	l = @@letter				
	
	if @@guess == 1
		m = "You have lost"
		d = @@dash.join
		word = @@word
		g = @@guess
		m_guess = @@m_guess
	else
		if  @@word.include? l
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
			
		else
			if @@m_guess.include? l
				m = "You have already tried this letter. Try a different one!"
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

	
end



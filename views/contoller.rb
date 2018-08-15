require ('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')

require_relative('models/game')
also_reload('./models/*')


get '/' do
  erb(:home)
end

get '/rock' do
  @solution = RockPaperScissors.choose_rock().to_s
  if @solution == 'won'
    @result = 'scissors'
  elsif @solution == 'lost'
    @result = 'paper'
  end
  erb(:rock)
end

get '/paper' do
  @solution = RockPaperScissors.choose_paper().to_s
  if @solution == 'won'
    @result = 'rock'
  elsif @solution == 'lost'
    @result = 'scissors'
  end
  erb(:paper)
end

get '/scissors' do
  @solution = RockPaperScissors.choose_scissors().to_s
  if @solution == 'won'
    @result = 'paper'
  elsif @solution == 'lost'
    @result = 'rock'
  end
  erb(:scissors)
end

require 'sinatra'
require 'json'

require File.expand_path('../lib/movie-suggestions.rb', __FILE__)

get '/' do
  File.read(File.join('public', 'index.html'))
end

post '/getMovieByCriteria' do

end

post '/getMovieByMovie' do

end
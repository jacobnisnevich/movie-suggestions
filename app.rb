require 'sinatra'
require 'json'

require File.expand_path('../lib/movie-suggestions.rb', __FILE__)

get '/' do
  File.read(File.join('public', 'index.html'))
  movie = Movie.new("name", 2000, ["Tom Cruise","Will Smith", "George Clooney"], ["comedy"], "director")
  criteria = {end_year=>2005, start_year=>1995, actors=>["Tom Cruise","Will Smith"], genres=>["action", "comedy"], director=>"director" }
end

post '/getMovieByCriteria' do

end

post '/getMovieByMovie' do

end
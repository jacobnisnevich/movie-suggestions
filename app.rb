require 'sinatra'
require 'json'

require File.expand_path('../lib/movie-suggestions.rb', __FILE__)

get '/' do
  File.read(File.join('public', 'index.html'))
end

post '/getMovieByCriteria' do
  movie_criteria = {
    "start_year" => params[:start_year].to_i,
    "end_year" => params[:end_year].to_i,
    "actors" => params[:actors],
    "genres" => params[:genres],
    "directors" => params[:directors]
  }

  movieSuggestor = MovieSuggestor.new
  movieSuggestor.get_suggestions_by_criteria(movie_criteria)
end

post '/getMovieByMovie' do
  movieSuggestor = MovieSuggestor.new
  movieSuggestor.get_suggestions_by_movie(params[:name])
end

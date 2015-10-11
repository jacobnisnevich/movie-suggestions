require 'sinatra'
require 'json'

require File.expand_path('../lib/movie-suggestions.rb', __FILE__)

get '/' do
  File.read(File.join('public', 'index.html'))
end

post '/getMovieByCriteria' do
  actors_cleaned = []
  params[:actors].each do |actor|
    actors_cleaned.push(actor.strip)
  end

  directors_cleaned = []
  params[:directors].each do |director|
    directors_cleaned.push(director.strip)
  end

  genres_cleaned = []
  params[:genres].each do |genre|
    genres_cleaned.push(genre.strip)
  end

  p actors_cleaned
  p directors_cleaned
  p genres_cleaned

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

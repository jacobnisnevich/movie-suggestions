require 'json'
require 'spotlite'
require 'open-uri'
require 'nokogiri'
require 'themoviedb'

[
  "movie.rb",
  "imdb-parser.rb",
  "movie-suggestor.rb"
].each do |file_name|
  require File.expand_path("../movie-suggestions/#{file_name}", __FILE__)
end

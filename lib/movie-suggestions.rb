require 'json'
require 'spotlite'

[
  "movie-suggestor.rb"
].each do |file_name|
  require File.expand_path("../movie-suggestions/#{file_name}", __FILE__)
end
class MovieSuggestor
  def initialize

  end

  def get_suggestions_by_criteria(movie_criteria)
    imdbParser = IMDBParser.new
    @resultMovies = imdbParser.search_by_criteria(movie_criteria)

    @resultsHash = {}
    @resultMovies.each do |movie|
      @resultsHash[movie.name] = get_score(movie, movie_criteria)
    end

    @resultMovies.sort {|movie_a, movie_b| @resultsHash[movie_b.name] <=> @resultsHash[movie_a.name]}

    moviesArrayOfHashes = []
    @resultMovies[0..9].each do |movie|
      moviesArrayOfHashes.push(movie.to_h)
    end

    moviesArrayOfHashes.to_json
  end

  def get_suggestions_by_movie(movie_name)
    movie = Spotlite::Movie.find(movie_name).first

    movie_actors = []
    movie.cast[0..2].each do |actor|
      movie_actors.push(actor.name)
    end

    movie_criteria = {
      "start_year" => movie.year.to_i,
      "end_year" => movie.year.to_i,
      "actors" => movie_actors,
      "genres" => movie.genres,
      "directors" => [movie.directors.first.name]
    }

    get_suggestions_by_criteria(movie_criteria)
  end 

  def get_score(movie, criteria)
    score = 0
    actors_in_common = (movie.actors.map(&:downcase) & criteria["actors"].map(&:downcase)).length 
    genres_in_common = (movie.genres.map(&:downcase) & criteria["genres"].map(&:downcase)).length
    if movie.year.to_i <= criteria["end_year"]  && movie.year.to_i >= criteria["start_year"] 
      score += 15
    elsif move.year.to_i <= criteria["end_year"] + 5 && movie.year.to_i >= criteria["start_year"] - 5
      score += 10
    end

    if criteria["directors"].map(&:downcase).include? movie.director.downcase
      score += 30
    end

    if actors_in_common >= 3 
      score += 20
    elsif actors_in_common == 2
      score += 15
    else
       score += 10
    end 

    if genres_in_common == 1
      score += 35
    elsif genres_in_common ==2 or genres_in_common ==3 
      score += 20
    end 
  
    score
  end
end
class MovieSuggestor
  def initialize

  end

  def get_suggestions_by_criteria(movie_criteria)
    
  end

  def get_suggestions_by_movie(movie_name)

  end 

  def get_score(movie, criteria)
    score = 0
    actors_in_common = (movie.actors & criteria.actors).length 
    genres_in_common = (movie.genres & criteria.genres).length
    if movie.year <= criteria.end_year  && movie.year >= criteria.start_year 
      score += 15
    elsif move.year <= criteria.end_year + 5 && movie.year >= criteria.start_year - 5
      score += 10
    end

    if movie.director == criteria.director
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
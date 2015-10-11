class IMDBParser
  def initialize
    @all_movies = []
  end

  def search_by_criteria(movie_criteria)
    genres = movie_criteria["genres"].join(",").sub('-', '_')

    if movie_criteria["actors"].length == 0 && movie_criteria["directors"].length == 0
      get_top_movies("http://www.imdb.com/search/title?genres=#{genres}&release_date=#{movie_criteria["start_year"]},#{movie_criteria["end_year"]}&title_type=feature,tv_movie")
    else
      movie_criteria["actors"].each do |actor|
        if actor != ""
          actor_id = get_person_id(actor)
          get_top_movies("http://www.imdb.com/search/title?genres=#{genres}&release_date=#{movie_criteria["start_year"]},#{movie_criteria["end_year"]}&role=#{actor_id}&title_type=feature,tv_movie")
        end
      end
      movie_criteria["directors"].each do |director|
        if director != ""
          director_id = get_person_id(director)
          get_top_movies("http://www.imdb.com/search/title?genres=#{genres}&release_date=#{movie_criteria["start_year"]},#{movie_criteria["end_year"]}&role=#{director_id}&title_type=feature,tv_movie")
        end
      end
    end

    @all_movies.uniq {|movie| movie.name}
  end

  def get_person_id(name)
    p name
    "nm#{Spotlite::Person.find(name)[0].imdb_id}"
  end

  def get_top_movies(link)
    doc = Nokogiri::HTML(open(link))
    doc.css(".results tr").each_with_index do |search_result, index|
      if index != 0
        movie_name = search_result.css(".title a")[0].text
        movie_year = search_result.css(".year_type").text[/\((.*)\)/,1]
        movie_director = search_result.css(".credit a")[0].text
        movie_actors = []
        search_result.css(".credit a").each_with_index do |actor_credit, index|
          if index != 0
            movie_actors.push(actor_credit.text)
          end
        end
        movie_genres = []
        search_result.css(".genre a").each do |genre|
          movie_genres.push(genre.text)
        end

        @all_movies.push(Movie.new(movie_name, movie_year, movie_actors, movie_genres, movie_director))
      end
    end
  end
end

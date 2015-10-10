class IMDBParser
  def initialize
    @all_movies = []
  end

  def search_by_criteria(movie_criteria)
    genres = movie_criteria["genres"].join(",").sub('-', '_')

    if movie_criteria["actors"].length == 0 && movie_criteria["director"].length == 0
      get_top_movies("http://www.imdb.com/search/title?genres=#{genres}&release_date=#{movie_criteria["start_year"]},#{movie_criteria["end_year"]}&title_type=feature,tv_movie")
    else
      movie_criteria["actors"].each do |actor|
        actor_id = get_person_id(actor)
        get_top_movies("http://www.imdb.com/search/title?genres=#{genres}&release_date=#{movie_criteria["start_year"]},#{movie_criteria["end_year"]}&role=#{actor_id}&title_type=feature,tv_movie")
      end
      movie_criteria["director"].each do |director|
        director_id = get_person_id(director)
        get_top_movies("http://www.imdb.com/search/title?genres=#{genres}&release_date=#{movie_criteria["start_year"]},#{movie_criteria["end_year"]}&role=#{director_id}&title_type=feature,tv_movie")
      end
    end

    @all_movies
  end

  def get_person_id(name)
    "nm#{Spotlite::Person.find(name)[0].imdb_id}"
  end

  def get_top_movies(link)
    doc = Nokogiri::HTML(open(link))
    doc.css(".results tr").each_with_index do |search_result, index|
      if index != 0
        movie_name = search_result.css(".title a")[1].text
        movie_year = search_result.css(".year_type").text[/\((.*)\)/,1]
        movie_director = search_result.css(".credit a")[0].text
        movie_actors = [search_result.css(".credit a")[1].text, 
                        search_result.css(".credit a")[2].text, 
                        search_result.css(".credit a")[3].text]
        movie_genres = []
        search_result.css(".genre a").each do |genre|
          movie_genres.push(genre.text)
        end

        p movie_name
        p movie_year
        p movie_director
        p movie_actors
        p movie_genres

        @all_movies.push(Movie.new(movie_name, movie_year, movie_actors, movie_genres, movie_director))
      end
    end
  end
end

if __FILE__ == $0
  movie_criteria = {
    "genres" => ["action", "sci-fi"],
    "actors" => ["tom cruise"],
    "start_year" => 2000,
    "end_year" => 2010
  }

  parser = IMDBParser.new
  parser.search_by_criteria(movie_criteria)
end
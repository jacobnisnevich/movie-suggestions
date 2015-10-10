class Movie
  attr_reader :name, :year, :actors, :genres, :director
  
  def initialize(name, year, actors, genres, director)
  	@name = name
  	@year = year
  	@actors = actors
  	@gneres = genres
  	@director = director
  end

end
$(document).ready(function() {
	$("#by-criteria-submit").click(function() {
		$("#look-up-view").hide();
		$("#loading-view").show();

		$.post("/getMovieByCriteria", {
			"start_year": $("#by-criteria-start_year").val(),
			"end_year": $("#by-criteria-end_year").val(),
			"actors": $("#by-criteria-actors").val().split(','),
			"genres": $("#by-criteria-genres").val().split(','),
			"directors": $("#by-criteria-directors").val().split(',')
		}, function(data) {
			loadResults(data);
		});
	});

	$("#by-movie-submit").click(function() {
		$("#look-up-view").hide();
		$("#loading-view").show();

		$.post("/getMovieByMovie", {
			"name": $("#by-movie-movie").val()
		}, function(data) {
			loadResults(data);
		});
	});

	$("#back-button").click(function() {
		$("#results-view").hide();
		$("#look-up-view").show();
	});
});

var loadResults = function(data) {
	$("#loading-view").hide();
	$("#results-view").show();
	
	$("#results-table").empty();

	data = JSON.parse(data);
	data.forEach(function(movieSuggestion) {
		$("#results-table").append("<div"+ movieSuggestion.name + "</div>")
		if (movieSuggestion.images!== null)
		$("#results-table").append("<div>"  + "<img src='" + movieSuggestion.images + "'> </div>");

	});
};
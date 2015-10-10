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

	$("#back-one-button").click(backOneSlide);

	$("#forward-one-button").click(forwardOneSlide);
});

var currentSlide = 0;
var movieSuggestions = [];

var backOneSlide = function() {
	updateResultDisplay();
	
	$("#forward-one-button").prop('disabled', false);

	if (currentSlide == 0) {
		$("#back-one-button").prop('disabled', true);
	}
};

var forwardOneSlide = function() {
	updateResultDisplay();

	$("#back-one-button").prop('disabled', false);

	if (currentSlide == movieSuggestions.length - 1) {
		$("#forward-one-button").prop('disabled', true);
	}
};

var updateResultDisplay = function() {
	movieSuggestion = movieSuggestions[currentSlide];
	if (movieSuggestion.images != null) {
		$("#results-movie-title").text(movieSuggestion.name);
		$("#results-movie-img img").attr("src", movieSuggestion.images);
	} else {
		$("#results-movie-title").text(movieSuggestion.name);
	}
};

var loadResults = function(data) {
	$("#loading-view").hide();
	$("#results-view").show();
	
	$("#results-table").empty();

	data = JSON.parse(data);
	movieSuggestions = data;

	updateResultDisplay();
};
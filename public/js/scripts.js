$(document).ready(function() {
	$("#by-criteria-submit").click(function() {
		$("#look-up-view").hide();
		$("#loading-view").show();
		currentSlide = 0;

		$.post("/getMovieByCriteria", {
			"start_year": $("#by-criteria-start_year").val(),
			"end_year": $("#by-criteria-end_year").val(),
			"actors": $("#by-criteria-actors").val().trim().split(','),
			"genres": $("#by-criteria-genres").val().trim().split(','),
			"directors": $("#by-criteria-directors").val().trim().split(',')
		}, function(data) {
			loadResults(data);
		});
	});

	$("#by-movie-submit").click(function() {
		$("#look-up-view").hide();
		$("#loading-view").show();
		currentSlide = 0;

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
	currentSlide--;
	
	$("#forward-one-button").prop('disabled', false);

	if (currentSlide == 0) {
		$("#back-one-button").prop('disabled', true);
	}

	updateResultDisplay();
};

var forwardOneSlide = function() {
	currentSlide++;

	$("#back-one-button").prop('disabled', false);

	if (currentSlide == movieSuggestions.length - 1) {
		$("#forward-one-button").prop('disabled', true);
	}

	updateResultDisplay();
};

var updateResultDisplay = function() {
	movieSuggestion = movieSuggestions[currentSlide];
	if (movieSuggestion.images != null) {
		$("#results-movie-title").text(movieSuggestion.name);
		$("#results-movie-img img").attr("src", movieSuggestion.images);
	} else {
		$("#results-movie-title").text(movieSuggestion.name);
		$("#results-movie-img img").attr("src", "");
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
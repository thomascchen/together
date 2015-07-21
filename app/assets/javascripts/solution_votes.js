$(".solution-upvote").on("click", function(event) {
  event.preventDefault();
  var userId = $(this).attr("data-user-id");
  var solutionId = $(this).attr("data-solution-id");
  var voteTotal = +$(this).text().match(/\d+/)[0]
  voteTotal++;

  $(this).hide();
  $(this).closest(".solution-vote").find(".cancel-vote-" + solutionId).show()
    .text('+ ' + voteTotal);

  $.ajax({
    type: "POST",
    url: "/solutions/" + solutionId + "/solution_votes",
    data: { "user_id": userId, "solution_id": solutionId, "vote": 1 },
    dataType: "json",
    success: function() {
    }
  });
});

$(".solution-cancel-vote").on("click", function(event) {
  event.preventDefault();
  var userId = $(this).attr("data-user-id");
  var solutionId = $(this).attr("data-solution-id");
  var voteTotal = +$(this).text().match(/\d+/)[0]
  voteTotal--;

  $(this).hide();
  $(this).closest(".solution-vote").find(".upvote-" + solutionId).show()
    .text('+ ' + voteTotal);

  $.ajax({
    type: "POST",
    url: "/solutions/" + solutionId + "/solution_votes",
    data: { "user_id": userId, "solution_id": solutionId, "vote": 0 },
    dataType: "json",
    success: function() {
    }
  });
});

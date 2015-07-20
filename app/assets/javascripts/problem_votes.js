$(".problem-upvote").on("click", function(event) {
  event.preventDefault();
  var userId = $(this).attr("data-user-id");
  var problemId = $(this).attr("data-problem-id");
  var voteTotal = $(this).closest(".vote").find(
    ".vote-score-" + problemId
  ).text();
  voteTotal++;
  $(this).closest(".vote").find(".vote-score-" + problemId).text(voteTotal);
  $(this).hide();
  $(this).closest(".problem-vote").find(".cancel-vote-" + problemId).show();

  $.ajax({
    type: "POST",
    url: "/problems/" + problemId + "/problem_votes",
    data: { "user_id": userId, "problem_id": problemId, "vote": 1 },
    dataType: "json",
    success: function() {
    }
  });
});

$(".problem-cancel-vote").on("click", function(event) {
  event.preventDefault();
  var userId = $(this).attr("data-user-id");
  var problemId = $(this).attr("data-problem-id");
  var voteTotal = $(this).closest(".vote").find(
    ".vote-score-" + problemId
  ).text();
  voteTotal--;
  $(this).closest(".vote").find(".vote-score-" + problemId).text(voteTotal);
  $(this).hide();
  $(this).closest(".problem-vote").find(".upvote-" + problemId).show();

  $.ajax({
    type: "POST",
    url: "/problems/" + problemId + "/problem_votes",
    data: { "user_id": userId, "problem_id": problemId, "vote": 0 },
    dataType: "json",
    success: function() {
    }
  });
});

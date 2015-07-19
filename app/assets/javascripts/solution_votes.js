// $(document).ready(function() {
//   $(".hidden").hide()
// });

$(".solution-upvote").on("click", function(event) {
  event.preventDefault();
  var userId = $(this).attr("data-user-id");
  var solutionId = $(this).attr("data-solution-id");
  var voteTotal = $(this).closest(".vote").find(
    ".vote-score-" + solutionId
  ).text();
  voteTotal++;
  $(this).closest(".vote").find(".vote-score-" + solutionId).text(voteTotal);
  $(this).hide();
  $(this).closest(".solution-vote").find(".cancel-vote-" + solutionId).show();
  // $(this).closest('.vote').find('.vote-container').append("<span class='cancel-vote'><a data-problem-id=\"" + problemId + "\" data-vote-id=\"" + problemId + "\" class=\"cancel-vote-" + problemId +"\" href=\"javascript:void(0)\">Cancel vote</a></span>");

  $.ajax({
    type: "POST",
    url: "/solutions/" + solutionId + "/solution_votes",
    data: { "user_id": userId, "solution_id": solutionId, "vote": 1 },
    dataType: "json",
    success: function(response) {
    // $('.upvote-' + response.problem_id).closest('.vote-container').append("<span class='cancel-vote'><a data-problem-id=\"" + response.problem_id + "\" data-vote-id=\"" + response.id + "\" class=\"cancel-vote-" + response.problem_id +"\" href=\"javascript:void(0)\">Cancel vote</a></span>");
    // $('.upvote-' + response.problem_id).closest('.vote-container').replaceWith("<span class='cancel-vote' ><%= link_to 'Cancel vote', 'javascript:void(0)', data: { problem_id: " + response.problem_id + ", vote_id: " + response.id + ", class: \"cancel-vote-#{" + response.problem_id + "}\" %></span>");
    }
  });
});

$(".solution-cancel-vote").on("click", function(event) {
  event.preventDefault();
  var userId = $(this).attr("data-user-id");
  var solutionId = $(this).attr("data-solution-id");
  var voteTotal = $(this).closest(".vote").find(
    ".vote-score-" + solutionId
  ).text();
  voteTotal--;
  $(this).closest(".vote").find(".vote-score-" + solutionId).text(voteTotal);
  $(this).hide();
  $(this).closest(".solution-vote").find(".upvote-" + solutionId).show();

  $.ajax({
    type: "POST",
    url: "/solutions/" + solutionId + "/solution_votes",
    data: { "user_id": userId, "solution_id": solutionId, "vote": 0 },
    dataType: "json",
    success: function(response) {
    // $('.cancel-vote-' + response.problem_id).closest('.vote-container').replaceWith("<span class='upvote' ><%= link_to 'Upvote', 'javascript:void(0)', data: { user_id: " + response.user_id ", problem_id: " + response.problem_id + " }, class: 'upvote-#{" + response.problem_id + "}' %></span>");
    // $('.cancel-vote-' + response.problem_id).closest('.vote-container').replaceWith("<span class='upvote' ><a data-user-id='" + response.user_id + " data-problem-id='" + response.problem_id + " class='upvote-" + response.problem_id + " href='javascript:void(0)'>Upvote</a></span>");
    }
  });
});

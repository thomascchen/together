$(".upvote").on("click", "a", function(event) {
  event.preventDefault();
  var userId = $(this).attr("data-user-id");
  var problemId = $(this).attr("data-problem-id");
  var voteTotal = $(this).closest('.vote').find('.vote-score-' + problemId).text();
  voteTotal++
  $(this).closest('.vote').find('.vote-score-' + problemId).text(voteTotal);
  $(this).closest('.upvote').find('.upvote-' + problemId).hide();
  // $(this).closest('.vote').find('.vote-container').append("<span class='cancel-vote'><a data-problem-id=\"" + problemId + "\" data-vote-id=\"" + problemId + "\" class=\"cancel-vote-" + problemId +"\" href=\"javascript:void(0)\">Cancel vote</a></span>");

  $.ajax({
    type: "POST",
    url: "/problems/" + problemId + "/problem_votes",
    data: { "user_id": userId, "problem_id": problemId },
    dataType: "json",
    success: function(response) {
    // $('.upvote-' + response.problem_id).closest('.vote-container').append("<span class='cancel-vote'><a data-problem-id=\"" + response.problem_id + "\" data-vote-id=\"" + response.id + "\" class=\"cancel-vote-" + response.problem_id +"\" href=\"javascript:void(0)\">Cancel vote</a></span>");
    // $('.upvote-' + response.problem_id).closest('.vote-container').replaceWith("<span class='cancel-vote' ><%= link_to 'Cancel vote', 'javascript:void(0)', data: { problem_id: " + response.problem_id + ", vote_id: " + response.id + ", class: \"cancel-vote-#{" + response.problem_id + "}\" %></span>");
    }
  });
});

$(".cancel-vote").on("click", "a", function(event) {
  event.preventDefault();
  var voteId = $(this).attr("data-vote-id");
  var problemId = $(this).attr("data-problem-id");
  var voteTotal = $(this).closest('.vote').find('.vote-score-' + problemId).text();
  voteTotal--
  $(this).closest('.vote').find('.vote-score-' + problemId).text(voteTotal);
  $(this).closest('.vote').find('.cancel-vote').hide();

  $.ajax({
    type: "DELETE",
    url: "/problems/" + problemId + "/problem_votes/" + voteId,
    data: { "problem_id": problemId, "vote_id": voteId },
    dataType: "json",
    success: function(response) {
    // $('.cancel-vote-' + response.problem_id).closest('.vote-container').replaceWith("<span class='upvote' ><%= link_to 'Upvote', 'javascript:void(0)', data: { user_id: " + response.user_id ", problem_id: " + response.problem_id + " }, class: 'upvote-#{" + response.problem_id + "}' %></span>");
    // $('.cancel-vote-' + response.problem_id).closest('.vote-container').replaceWith("<span class='upvote' ><a data-user-id='" + response.user_id + " data-problem-id='" + response.problem_id + " class='upvote-" + response.problem_id + " href='javascript:void(0)'>Upvote</a></span>");
    }
  });
});

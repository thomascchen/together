class Solved::ProblemsController < ApplicationController
  def index
    @problems = Problem.find_by_sql("
      SELECT problems.id, problems.title, problems.description,
        problems.category_id, problems.urgency_level_id, problems.status_id,
        problems.user_id, problems.created_at, problems.updated_at,
        problems.photo,
      SUM(problem_votes.vote)
      FROM problems
      LEFT JOIN problem_votes
      ON problems.id = problem_votes.problem_id
      WHERE problems.status_id = 2
      GROUP BY problems.id
      ORDER BY problems.urgency_level_id ASC, problems.updated_at DESC,
        SUM(problem_votes.vote) DESC;
    ")
  end
end

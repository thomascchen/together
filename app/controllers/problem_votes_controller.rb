class ProblemVotesController < ApplicationController
  def create
    if params[:problem_id]
      @problem = Problem.find(params[:problem_id])
      @vote = ProblemVote.find_or_create_by(
        user_id: params[:user_id],
        problem_id: params[:problem_id]
      )
      @vote.update(vote: params[:vote])
    end

    respond_to do |format|
      format.json { render json: @vote }
    end
  end
end

class ProblemVotesController < ApplicationController
  def create
    @problem = Problem.find(params[:problem_id])
    @vote = ProblemVote.create(
      problem_id: params[:problem_id], user_id: params[:user_id]
    )

    respond_to do |format|
      format.json { render json: @vote }
    end
  end

  def destroy
    @problem = Problem.find(params[:problem_id])
    if params[:vote_id]
      @vote = ProblemVote.find(params[:vote_id])
      @vote.destroy
    end

    respond_to do |format|
      format.json { render json: @vote }
    end
  end
end

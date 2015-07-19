class ProblemVotesController < ApplicationController
  def create
    if params[:problem_id]
      @problem = Problem.find(params[:problem_id])
      @vote = ProblemVote.create(
        problem_id: params[:problem_id], user_id: params[:user_id]
      )
    end

    respond_to do |format|
      format.json { render json: @vote }
    end
  end

  def destroy
    if params[:problem_id]
      @problem = Problem.find(params[:problem_id])
    end
    if params[:vote_id]
      @vote = ProblemVote.find(params[:vote_id])
      @vote.destroy
    end

    respond_to do |format|
      format.json { render json: @vote }
    end
  end
end

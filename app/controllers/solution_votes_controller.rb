class SolutionVotesController < ApplicationController
  def create
    if params[:solution_id]
      @solution = Solution.find(params[:solution_id])
      @vote = SolutionVote.find_or_create_by(
        solution_id: params[:solution_id],
        user_id: params[:user_id]
      )
      @vote.update(vote: params[:vote])
    end

    respond_to do |format|
      format.json { render json: @vote }
    end
  end
end

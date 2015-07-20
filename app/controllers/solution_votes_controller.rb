class SolutionVotesController < ApplicationController
  before_action :authenticate_user!

  def create
    if params[:solution_id]
      @solution = Solution.find(params[:solution_id])
      @vote = SolutionVote.find_or_create_by(
        user_id: params[:user_id],
        solution_id: params[:solution_id]
      )
      @vote.update(vote: params[:vote])
    end

    respond_to do |format|
      format.json { render json: @vote }
    end
  end
end

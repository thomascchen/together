class SolutionsController < ApplicationController
  def create
    @problem = Problem.find(params[:problem_id])
    @solution = Solution.new(solution_params)
    @solution.problem = @problem
    @solution.user = current_user

    if @solution.save
      flash[:info] = "Solution saved"
      redirect_to problem_path(@problem)
    else
      flash[:alert] = "Failed to save solution"
      redirect_to problem_path(@problem)
    end
  end

  def format_datetime(time)
    time.strftime("%B %e, %Y at %l:%M:%S %p")
  end

  private

  def solution_params
    params.require(:solution).permit(
      :title,
      :description,
      :accepted,
      :user_id,
      :problem_id,
    )
  end
end

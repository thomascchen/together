class SolutionsController < ApplicationController
  def create
    @problem = Problem.find(params[:problem_id])
    @solution = Solution.new(solution_params)
    @solution.problem = @problem
    @solution.user = current_user

    if @solution.save
      flash[:success] = "Solution saved"
      redirect_to problem_path(@problem)
    else
      flash[:error] = "Failed to save solution"
      redirect_to problem_path(@problem)
    end
  end

  def edit
    @solution = Solution.find(params[:id])
    @problem = @solution.problem
  end

  def update
    @solution = Solution.find(params[:id])
    @problem = @solution.problem
    if @solution.update(solution_params)
      flash[:success] = "Solution updated"
      redirect_to problem_path(@problem)
    else
      flash[:error] = "Failed to save solution"
      render :edit
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

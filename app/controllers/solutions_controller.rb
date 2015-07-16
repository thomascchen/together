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
    if params["solution"]["existing_problem_attributes"]
      num = params["solution"]["existing_problem_attributes"]["status_id"].to_i
      @solution.update(solution_params)
      @problem.update(
        status_id: num
      )
      flash[:success] = "Problem and solution updated"
      redirect_to problem_path(@problem)
    elsif @solution.update(solution_params)
      flash[:success] = "Solution updated"
      redirect_to problem_path(@problem)
    else
      flash[:error] = "Failed to save solution"
      render :edit
    end
  end

  def destroy
    @solution = Solution.find(params[:id])
    @problem = @solution.problem
    if @solution.destroy
      flash[:success] = "Solution deleted"
    else
      flash[:error] = "Solution not deleted"
    end
    redirect_to problem_path(@problem)
  end

  private

  def solution_params
    params.require(:solution).permit(
      :title,
      :description,
      :accepted,
      :user_id,
      :problem_id
    )
  end
end

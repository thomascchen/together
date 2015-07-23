class ProblemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id]) unless !params[:user_id]
    @problems = Problem.find_by_sql("
      SELECT problems.id, problems.title, problems.description,
        problems.category_id, problems.urgency_level_id, problems.status_id,
        problems.user_id, problems.created_at, problems.updated_at,
        problems.photo,
      SUM(problem_votes.vote)
      FROM problems
      LEFT JOIN problem_votes
      ON problems.id = problem_votes.problem_id
      WHERE problems.status_id = 1
      GROUP BY problems.id
      ORDER BY problems.urgency_level_id ASC, problems.updated_at DESC,
        SUM(problem_votes.vote) DESC NULLS LAST;
    ")
  end

  def show
    @problem = Problem.find(params[:id])
    @solution = Solution.new
    @solutions = Solution.find_by_sql("
      SELECT problems.id, solutions.id, solutions.title, solutions.description,
        solutions.accepted, solutions.user_id, solutions.problem_id,
        solutions.created_at, solutions.updated_at,
      SUM(solution_votes.vote)
      FROM problems
      JOIN solutions
      ON problems.id = solutions.problem_id
      LEFT JOIN solution_votes
      ON solutions.id = solution_votes.solution_id
      WHERE problems.id = #{@problem.id}
      GROUP BY problems.id, solutions.id
      ORDER BY SUM(solution_votes.vote) DESC NULLS LAST,
        solutions.updated_at DESC;
    ")
  end

  def new
    @user = User.find(params[:user_id])
    @problem = Problem.new
    @categories = Category.all
    @urgency_levels = UrgencyLevel.all
  end

  def create
    @user = User.find(params[:user_id])
    @problem = Problem.new(problem_params)
    @problem.user = @user
    @categories = Category.all
    @urgency_levels = UrgencyLevel.all
    if @problem.save
      flash[:success] = "Problem submitted"
      redirect_to problem_path(@problem)
    else
      flash.now[:error] = "Problem not saved"
      render :new
    end
  end

  def edit
    @problem = Problem.find(params[:id])
    @user = @problem.user
    @categories = Category.all
    @urgency_levels = UrgencyLevel.all
  end

  def update
    @problem = Problem.find(params[:id])
    @categories = Category.all
    @urgency_levels = UrgencyLevel.all
    if @problem.update(problem_params)
      flash[:success] = "Problem updated"
      redirect_to problem_path(@problem)
    else
      flash.now[:error] = "Problem not updated"
      render :edit
    end
  end

  def destroy
    @problem = Problem.find(params[:id])
    if @problem.destroy
      flash[:success] = "Problem deleted"
    else
      flash[:error] = "Problem not deleted"
    end
    redirect_to problems_path
  end

  private

  def problem_params
    params.require(:problem).permit(
      :title,
      :description,
      :status_id,
      :category_id,
      :urgency_level_id,
      :user_id,
      :photo
    )
  end
end

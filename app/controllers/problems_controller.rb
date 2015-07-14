class ProblemsController < ApplicationController
  def index
    @problems = Problem.where(status_id: 1).order(
      :urgency_level_id,
      updated_at: :desc
    )
    @user = User.find(params[:user_id]) unless !params[:user_id]
  end

  def show
    @problem = Problem.find(params[:id])
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
      redirect_to problems_path
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
      :user_id
    )
  end
end

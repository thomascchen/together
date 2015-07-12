class ProblemsController < ApplicationController
  def index
    @problems = Problem.where(status_id: 1).order(:urgency_level_id)
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
      redirect_to problem_path(@problem)
    else
      flash[:error] = "Problem not saved"
      render :new
    end
  end

  def update
    if params[:user_id]
      @user = User.find(params[:user_id])
    end
  end

  def destroy
    if params[:user_id]
      @user = User.find(params[:user_id])
    end
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

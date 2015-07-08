class ProblemsController < ApplicationController
  def index
    @problems = Problem.all
    if params[:user_id]
      @user = User.find(params[:user_id])
    end
  end

  def show
    @problem = Problem.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @problem = Problem.new
  end

  def create
    @user = User.find(params[:user_id])
    @problem = Problem.new(problem_params)
    @problem.user = @user
    if @problem.save
      flash[:success] = "Problem posted successfully"
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
      :deadline,
      :status,
      :category_id,
      :user_id
    )
  end
end

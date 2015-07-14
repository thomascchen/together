class Solved::ProblemsController < ApplicationController
  def index
    @problems = Problem.where(status_id: 2).order(created_at: :desc)
  end
end

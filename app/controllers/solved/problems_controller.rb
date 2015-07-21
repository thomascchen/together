class Solved::ProblemsController < ApplicationController
  def index
    @problems = Problem.where(status_id: 2).order(updated_at: :desc)
  end
end

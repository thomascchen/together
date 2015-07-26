class ChartsController < ApplicationController
  def index
    @categories = Category.all
    @problems_count = Problem.count.to_f
    @category_types = @categories.map do |cat|
      { name: cat.name, y: (cat.problems.count.to_f / @problems_count).to_f }
    end

    @users = User.all

    @sorted_users = @users.sort_by do |user|
      ((user.problems.count.to_f + user.solutions.count.to_f) /
        (Problem.count.to_f + Solution.count.to_f)).to_f
    end.reverse

    @user_contributions = @sorted_users.map do |user|
      {
        name: user.name,
        y: ((((user.problems.count.to_f + user.solutions.count.to_f) /
          (Problem.count.to_f + Solution.count.to_f)).to_f) * 100).to_f,
        drilldown: user.name
      }
    end

    @contribution_breakdown = @sorted_users.map do |user|
      {
        name: user.name,
        id: user.name,
        data: [
          ['Problems Proposed',
            (((user.problems.count.to_f /
            (user.problems.count.to_f + user.solutions.count.to_f).to_f).to_f) * 100).to_f],
          ['Solutions Proposed',
            (((user.solutions.count.to_f /
            (user.problems.count.to_f + user.solutions.count.to_f).to_f).to_f) * 100).to_f],
          ['Solutions Accepted',
            (((user.solutions.where(accepted: true).count.to_f /
            (user.problems.count.to_f + user.solutions.count.to_f).to_f).to_f) * 100).to_f]
        ],
        total: ((user.problems.count.to_f + user.solutions.count.to_f) /
          (Problem.count.to_f + Solution.count.to_f)).to_f
      }
    end

    respond_to do |format|
      format.html
      format.json do render json:
        [@category_types, @user_contributions, @contribution_breakdown]
      end
    end
  end
end

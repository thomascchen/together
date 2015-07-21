require 'rails_helper'

feature 'user upvotes solution', %{
  As an authorized user,
  I can upvote a solution,
  So I can let people know that I think it’s a good solution.
} do

  # Acceptance Criteria:
  # [x] User can upvote a solution they think is especially important
  # [x] User can remove upvote on a solution if they change their mind
  # [x] User can only upvote once per solution
  # [x] User must be authenticated to vote
  # [x] Scores for solution votes are displayed on the problem show page.

  let(:category) { Category.create(name: "Heat and Essential") }
  let(:urgency_level) { UrgencyLevel.create(id: 1, name: "Immediate") }
  let(:open_status) { Status.create(id: 1, name: "Open") }
  let!(:solved_status) { Status.create(id: 2, name: "Solved") }
  let(:user) { FactoryGirl.create(:user) }
  let!(:open_problem) do
    FactoryGirl.create(
      :problem,
      user: user,
      category: category,
      urgency_level: urgency_level,
      status: open_status
    )
  end

  let!(:solved_problem) do
    FactoryGirl.create(
      :problem,
      user: user,
      category: category,
      urgency_level: urgency_level,
      status: solved_status
    )
  end

  let!(:accepted_solution) do
    Solution.create(
      title: "Good solution!",
      description: "Accept this!",
      problem: solved_problem,
      user: user,
      accepted: true
      )
  end

  let!(:proposed_solution) do
    Solution.create(
      title: "Bad solution!",
      description: "Don't accept this!",
      problem: open_problem,
      user: user,
      accepted: false
    )
  end

  scenario 'authenticated user upvotes and cancels vote on solution',
    js: true do
      sign_in(FactoryGirl.create(:user))
      click_on open_problem.title
      first(:link, '+ 0').click

      expect(page).to have_link('+ 1')
      expect(page).to_not have_selector('a.problem-upvote')

      click_on('+ 1')

      expect(page).to_not have_selector('a.cancel-vote')
      expect(page).to_not have_link('+ 1')
    end

  scenario 'unauthenticated user cannot vote on solution' do
    visit problem_path(open_problem)

    expect(page).to_not have_link('+ 0')
  end
end

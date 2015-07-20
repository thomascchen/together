require 'rails_helper'

feature 'user upvotes solution', %{
  As an authorized user,
  I can upvote a solution,
  So I can let people know that I think it’s a good solution.
} do

  # Acceptance Criteria:
  # [ ] User can upvote a solution they think is especially important
  # [ ] User can remove upvote on a solution if they change their mind
  # [ ] User cannot upvote on their own solution
  # [ ] User can only upvote once per solution
  # [ ] User must be authenticated to vote
  # [ ] User cannot upvote solutions on solved problems
  # [ ] Scores for solution votes are displayed on the problem show page.

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

  scenario 'authenticated user upvotes and cancels vote on solution', js: true do
    sign_in(FactoryGirl.create(:user))
    click_on open_problem.title
    click_on('Upvote Solution')

    expect(page).to have_content('Score: 1')
    expect(page).to_not have_link('Upvote Solution')

    click_on('Cancel Solution vote')

    expect(page).to have_content('Score: 0')
    expect(page).to_not have_content('Score: 1')
    expect(page).to have_link('Upvote Solution')
  end

  scenario 'authenticated user cannot vote on own solution' do
    sign_in(user)
    click_on open_problem.title

    expect(page).to_not have_link('Upvote Solution')
  end

  scenario 'unauthenticated user cannot vote on solution' do
    visit problem_path(open_problem)

    expect(page).to_not have_link('Upvote Solution')
  end

  scenario 'authenticated user cannot vote on solutions for solved problems' do
    sign_in(FactoryGirl.create(:user))
    click_on 'Solved Problems'
    click_on solved_problem.title

    expect(page).to_not have_link('Upvote Solution')
  end

end

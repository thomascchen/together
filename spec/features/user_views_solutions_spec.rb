require 'rails_helper'

feature 'user views solutions', %{
  As an authenticated user,
  I can view a list of proposed solutions for a problem,
  So I can see what my neighbors think should be done to solve a problem.
} do

  # Acceptance Criteria
  # [x] User can view a list of solutions for an unsolved problem
  # [x User can view a list of solutions for a solved problem
  # [x] Solutions should indicate if they have been accepted
  # [x] User must be authenticated to view solutions
  # [x] Solutions should have title, description, author, time created, and
  #     should show if they've been accepted

  let(:category) { Category.create(name: "Heat and Essential") }
  let(:urgency_level) { UrgencyLevel.create(id: 1, name: "Immediate") }
  let(:status) { Status.create(id: 1, name: "Open") }
  let(:status2) { Status.create(id: 2, name: "Solved") }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:open_problem) do
    FactoryGirl.create(
      :problem,
      user: user,
      category: category,
      urgency_level: urgency_level,
      status: status
    )
  end

  let!(:solved_problem) do
    FactoryGirl.create(
      :problem,
      user: user,
      category: category,
      urgency_level: urgency_level,
      status: status2
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

  scenario 'authenticated user views solutions to an open problem' do
    sign_in(user)
    click_on open_problem.title

    expect(page).to have_content(proposed_solution.title)
    expect(page).to have_content(proposed_solution.description)
    expect(page).to have_content(proposed_solution.user.name)
    expect(page).to have_content(proposed_solution.created_at.strftime("%B %e, %Y at %l:%M:%S %p"))
    expect(page).to_not have_content(accepted_solution.title)
  end

  scenario 'authenticated user views solutions to a solved problem' do
    sign_in(user)
    click_on 'Solved Problems'
    click_on solved_problem.title

    expect(page).to have_content(accepted_solution.title)
    expect(page).to have_content(accepted_solution.description)
    expect(page).to have_content(accepted_solution.user.name)
    expect(page).to have_content(accepted_solution.created_at.strftime("%B %e, %Y at %l:%M:%S %p"))
    expect(page).to have_content("Accepted")
    expect(page).to_not have_content(proposed_solution.title)
  end

  scenario 'unauthenticated user cannot view solutions to a problem' do
    visit problem_path(open_problem)
    expect(page).to_not have_content(proposed_solution.title)

    visit problem_path(solved_problem)
    expect(page).to_not have_content(accepted_solution.title)
  end

end

require 'rails_helper'

feature 'user accepts solution', %{
  As an authenticated user,
  I want to accept a solution to a problem I create,
  So that I can mark my problem solved
} do

  # Acceptance Criteria
  # [x] User can accept a solution to their problem
  # [x] User can unaccept a solution to their problem
  # [x] User must be authenticated to accept a solution
  # [x] When a user accepts a solution it becomes marked as so and the problem
  #     becomes marked as solved

  let(:category) { Category.create(name: "Heat and Essential") }
  let(:urgency_level) { UrgencyLevel.create(id: 1, name: "Immediate") }
  let(:open_status) { Status.create(id: 1, name: "Open") }
  let!(:solved_status) { Status.create(id: 2, name: "Solved") }
  let(:user) { FactoryGirl.create(:user) }
  let!(:problem) do
    FactoryGirl.create(
      :problem,
      user: user,
      category: category,
      urgency_level: urgency_level,
      status: open_status
    )
  end

  let!(:solution) do
    Solution.create(
      title: "This is my solution",
      description: "This is my solution description",
      user: user,
      problem: problem,
      accepted: false
    )
  end

  scenario 'authenticated user accepts and unaccepts solution' do
    sign_in(user)
    click_on problem.title
    click_on 'Accept Solution'

    expect(page).to have_content('Problem and solution updated')
    expect(page).to have_content(problem.title)
    expect(page).to have_content(solution.title)
    expect(page).to have_content('Accepted')
    within(".status-label") { expect(page).to have_content('Solved') }
    click_on 'Together'

    expect(page).to_not have_content(problem.title)

    click_on 'Solved Problems'

    expect(page).to have_content(problem.title)
    within(".main") { expect(page).to have_content('Solved') }

    click_on problem.title
    click_on 'Unaccept Solution'

    expect(page).to have_content('Problem and solution updated')
    expect(page).to have_content(problem.title)
    expect(page).to have_content(solution.title)
    expect(page).to have_button('Accept Solution')
  end

  scenario "authenticated user can't accept another user's solution" do
    sign_in(FactoryGirl.create(:user))

    click_on problem.title
    expect(page).to_not have_button('Accept Solution')
  end

  scenario "authenticated user can't unaccept another user's solution" do
    Solution.create(
        title: "Accepted solution",
        description: "This is my accepted solution description",
        user: user,
        problem: problem,
        accepted: true
      )
    sign_in(FactoryGirl.create(:user))

    click_on problem.title
    expect(page).to have_content('Accepted')
    expect(page).to_not have_button('Unaccept Solution')
  end

  scenario "unauthenticated user can't accept or unaccept solution they didn't
    create" do
    visit problem_path(problem)

    expect(page).to_not have_button('Accept Solution')
    expect(page).to_not have_button('Unaccept Solution')
  end
end

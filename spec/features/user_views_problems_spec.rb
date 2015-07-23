require 'rails_helper'

feature 'user views unsolved problems', %{
  As an authenticated user,
  I can view a list of problems,
  So I can learn about solved and unsolved problems in my building.
} do

  # Acceptance Criteria
  # [x] User can view a list of unsolved problems when visiting the root path
  # [x] Unsolved problems should be sorted by urgency level
  # [x] Title, category, urgency level, status, user's first and last name, and
  #     last updated time should be displayed alongside each problem
  # [x] User can click in to problem show page and see all of the same
  #     information for each problem

  let!(:category) { Category.create(name: "Heat and Essential") }
  let!(:urgency_level) { UrgencyLevel.create(id: 1, name: "Immediate") }
  let!(:urgency_level2) { UrgencyLevel.create(id: 3, name: "Not Urgent") }
  let!(:status) { Status.create(id: 1, name: "Open") }
  let!(:status2) { Status.create(id: 2, name: "Solved") }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:problem) do
    FactoryGirl.create(
      :problem,
      user: user,
      category: category,
      urgency_level: urgency_level,
      status: status
    )
  end

  let!(:solved_problem) do FactoryGirl.create(
      :problem,
      user: user,
      category: category,
      urgency_level: urgency_level,
      status: status2
    )
  end

  scenario 'user views list of unsolved problems' do
    open_problem2 = FactoryGirl.create(
      :problem,
      user: user,
      category: category,
      urgency_level: urgency_level2,
      status: status
    )

    sign_in(user)

    expect(page).to have_content(problem.title)
    expect(page).to have_content(problem.category.name)
    expect(page).to have_content(problem.urgency_level.name)
    expect(page).to have_content(problem.status.name)
    expect(page).to have_content(problem.user.name)
    expect(page).to have_content(
      problem.updated_at.strftime("%B %e, %Y at %l:%M:%S %p")
    )
    expect(page).to have_content(open_problem2.title)
    expect(page).to_not have_content(solved_problem.title)
    expect(page).to have_selector(
      "div .columns span:nth-child(1) a:first",
      text: problem.title
    )
    expect(page).to have_selector(
      "div .columns span:nth-child(1) a:last",
      text: open_problem2.title
    )
  end

  scenario 'user views problem show page' do
    sign_in(user)
    click_on problem.title

    expect(page).to have_content(problem.title)
    expect(page).to have_content(problem.description)
    expect(page).to have_content(problem.category.name)
    expect(page).to have_content(problem.urgency_level.name)
    expect(page).to have_content(problem.user.name)
    expect(page).to have_content(
      problem.updated_at.strftime("%B %e, %Y at %l:%M:%S %p")
    )
  end

  scenario 'user views list of solved problems' do
    solved_problem_2 = FactoryGirl.create(
      :problem,
      user: user,
      category: category,
      urgency_level: urgency_level2,
      status: status2
    )
    sign_in(user)

    click_on 'Solved Problems'

    expect(page).to have_content(solved_problem.title)
    expect(page).to have_content(solved_problem.category.name)
    expect(page).to have_content(solved_problem.status.name)
    expect(page).to have_content(solved_problem.user.name)
    expect(page).to have_content(
      solved_problem.updated_at.strftime("%B %e, %Y at %l:%M:%S %p")
    )
    expect(page).to have_content(solved_problem_2.title)
    expect(page).to_not have_content(problem.title)
    expect(page).to have_selector(
      "div .columns span:nth-child(1) a:first",
      text: solved_problem_2.title
    )
    expect(page).to have_selector(
      "div .columns span:nth-child(1) a:last",
      text: solved_problem.title
    )

  end
end

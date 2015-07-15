require 'rails_helper'

feature 'user updates solution', %{
  As an authorized user,
  I can update a solution,
  So that I can modify my proposed solution.
} do

  # Acceptance Criteria
  # [x] User can update a solution they created
  # [x] User can't update a solution they didn't create
  # [x] When user visits update solution page, they are shown a form that is
  #     filled out with existing information that they can update and resubmit
  # [x] When user submits updated solution, they are taken to the problem show
  #     page and given a success message
  # [x] If user submits invalid information, form is re-rendered and they are
  #     given error message.

  let!(:category) { Category.create(name: "Heat and Essential") }
  let!(:urgency_level) { UrgencyLevel.create(id: 1, name: "Immediate") }
  let!(:status) { Status.create(id: 1, name: "Open") }
  let(:user) { FactoryGirl.create(:user) }
  let!(:problem) do
    FactoryGirl.create(
      :problem,
      user: user,
      category: category,
      urgency_level: urgency_level,
      status: status
    )
  end

  let!(:solution) do
    Solution.create(
      title: "A solution!",
      description: "Accept this!",
      problem: problem,
      user: user,
      accepted: false
    )
  end

  scenario 'authenticated user submits valid information' do
    sign_in(user)
    click_on problem.title

    click_link('Edit', href: edit_problem_solution_path(problem, solution))

    fill_in 'Title', with: 'New solution'
    fill_in 'Description', with: 'I changed my mind.'
    click_on 'Submit'

    expect(page).to have_content('Solution updated')
    expect(page).to have_content('New solution')
    expect(page).to have_content('I changed my mind')
    expect(page).to_not have_content('A solution!')
    expect(page).to_not have_content('Accept this!')
  end

  scenario 'authenticated user submits invalid information' do
    sign_in(user)
    click_on problem.title

    click_link('Edit', href: edit_problem_solution_path(problem, solution))

    fill_in 'Title', with: ''
    fill_in 'Description', with: ''
    click_on 'Submit'

    expect(page).to have_content('Failed to save solution')
    expect(page).to_not have_content('Solution Saved!')

  end

  scenario 'unauthenticated user cannot update solution' do
    visit problem_path(problem)

    expect(page).to_not have_link(
      'Edit', href: edit_problem_solution_path(problem, solution)
    )
  end
end

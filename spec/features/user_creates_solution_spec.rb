require 'rails_helper'

feature 'user creates a new solution', %{
  As an authenticated user,
  I can share a solution to a problem,
  So that I can help my neighbors solve a problem.
} do

  # Acceptance Criteria
  # [x] User must specify a title and description for their problem
  # [x] After successful submission, user is shown a success message, and they
  #     are redirected to the problem show page
  # [x] If user submits incomplete information, they are shown an error message
  # [x] User must be authenticated to post a new solution
  # [x] User can submit a solution to their own problem

  let(:user) { FactoryGirl.create(:user) }
  let!(:problem) do
    FactoryGirl.create(
      :problem,
      user: user,
      category: Category.create(name: 'Heat and Essential'),
      urgency_level: UrgencyLevel.create(name: 'Immediate'),
      status: Status.create(id: 1, name: 'Open')
    )
  end

  scenario 'authenticated user enters valid information' do
    sign_in(user)
    click_on problem.title

    click_on 'Submit Solution'
    fill_in 'Title', with: "I have a solution!"
    fill_in 'Description', with: 'Here is my solution to your problem.'
    click_on 'Submit'

    expect(page).to have_content('Solution saved')
    expect(page).to have_content("I have a solution!")
    expect(page).to have_content("Here is my solution to your problem.")
  end

  scenario 'authenticated user enters invalid information' do
    sign_in(user)
    click_on problem.title

    click_on 'Submit Solution'
    click_on 'Submit'

    expect(page).to have_content('Failed to save solution')
    expect(page).to_not have_content("Solution saved")
  end

  scenario 'unauthenticated user cannot submit a new problem' do
    visit problem_path(problem)

    expect(page).to_not have_content("Submit")
  end
end

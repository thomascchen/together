require 'rails_helper'

feature 'user posts a new problem', %{
  As an authorized user,
  I want to post a new problem in my building,
  So that I can get help solving it with my neighbors
} do

  # Acceptance Criteria
  # [x] User must specify a title, description, and category for their problem
  # [x] User can optionally specify a deadline by which their problem must be
  #     resolved
  # [x] After successful submission, user is shown a success message, and they
  #     are redirected to problem show page
  # [ ] If user submits incomplete information, they are shown an error message
  #     and the form is re-rendered with previously entered information

  scenario 'authorized user enters valid information' do
    user = FactoryGirl.create(:user)
    category = Category.create(name: 'Utilities')
    sign_in(user)
    click_link('Post New Problem')
    fill_in 'Title', with: "Heat's broken!"
    fill_in 'Description', with: 'Heat is broken yet again!'
    select category.name, from: 'Category'
    fill_in 'problem_deadline', with: '2015-08-20'

    click_button('Post Your Problem')

    expect(page).to have_content('Problem posted successfully')
    expect(page).to have_content("Heat's broken!")
  end

  scenario 'authorized user enters invalid information'

end

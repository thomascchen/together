require 'rails_helper'

feature 'user posts a new problem', %{
  As an authorized user,
  I want to post a new problem in my building,
  So that I can get help solving it with my neighbors
} do

  # Acceptance Criteria
  # [ ] User must specify a title, description, category and urgency level for
  #     their problem
  # [ ] After successful submission, user is shown a success message, and they
  #     are redirected to their problem show page
  # [ ] If user submits incomplete information, they are shown an error message
  #     and the form is re-rendered with previously entered information
  # [ ] User must be authenticated to post a new problem

  scenario 'authorized user enters valid information' do
    user = FactoryGirl.create(:user)
    category = Category.create(name: 'Utilities')
    sign_in(user)
    click_link('Submit a Problem')
    fill_in 'Title', with: "Heat's broken!"
    fill_in 'Description', with: 'Heat is broken yet again!'
    select category.name, from: 'Category'


    click_button('Post Your Problem')

    expect(page).to have_content('Problem posted successfully')
    expect(page).to have_content("Heat's broken!")
  end

  scenario 'authorized user enters invalid information' do
    user = FactoryGirl.create(:user)
    category = Category.create(name: 'Utilities')
    sign_in(user)
    click_link('Post New Problem')

    click_button('Post Your Problem')

    expect(page).to have_content('Problem not saved')
    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Heat's broken!")
  end

end

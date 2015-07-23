require 'rails_helper'

feature 'user signs out', %{
  As an authenticated user
  I want to sign out
  So that my identity is forgotten about on the machine I'm using
  } do

  # Acceptance Criteria
  # [x] If I'm signed in, i have an option to sign out
  # [x] When I opt to sign out, I get a confirmation that my identity has been
  #   forgotten on the machine I'm using

  scenario 'authenticated user signs out' do
    user = FactoryGirl.create(:user)
    sign_in(user)

    expect(page).to have_content('Signed in successfully')

    click_link 'Sign Out'

    expect(page).to have_content('Sign In')
  end

  scenario 'unauthenticated user attempts to sign out' do
    visit root_path
    expect(page).to_not have_content('Sign Out')
  end
end

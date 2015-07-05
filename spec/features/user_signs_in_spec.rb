require 'rails_helper'

feature 'user signs in', %{
  As a signed up user
  I want to sign in
  So that I can regain access to my account
} do

  # Acceptance Criteria:
  # [x] If I specify valid, previously registered email and password, I am
  #     authenticated and I gain access to the system
  # [x] If I specify invalid email and password, I remain unauthenticated
  # [x] If I am already signed in, I can't sign in again

  let(:user) { FactoryGirl.create(:user) }

  scenario 'existing user specifies valid credentials'  do
    sign_in(user)

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_content('Sign Out')
    expect(page).to have_content('Problems')
  end

  scenario 'a nonexisting email and password is supplied' do
    visit root_path
    click_link 'Sign In'

    fill_in 'Email', with: 'john@smith.com'
    fill_in 'Password', with: 'wrongpassword'
    click_button 'Log in'

    expect(page).to have_content('Invalid email or password')
    expect(page).to_not have_content('Signed in successfully')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'existing user with wrong password is denied access' do
    visit root_path
    click_link 'Sign In'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'wrongpassword'
    click_button 'Log in'

    expect(page).to have_content('Invalid email or password')
    expect(page).to_not have_content('Signed in successfully')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'an already authenticated user cannot sign in' do
    sign_in(user)

    expect(page).to have_content('Sign Out')
    expect(page).to_not have_content('Sign In')
  end
end

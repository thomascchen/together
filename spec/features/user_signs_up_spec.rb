require 'rails_helper'

feature 'user registers', %{
  As a visitor
  I want to register
  So that I can create an account
} do

  # Acceptance Criteria:
  # [x] I must specify a valid email address, password, password
  #     confirmation, first name, last name, apartment number
  # [x] Upon successful submission, I am given a success message and redirected
  #     to Grievances page
  # [x] If I don't specify the required information, I am presented with
  #     an error message

  scenario 'provide valid registration information' do
    neighborhood = Neighborhood.create(name: 'Jamaica Plain')
    building = Building.create(
      street: '21 Jumpstreet',
      city: 'Boston',
      state: 'MA',
      zip: '01230',
      neighborhood_id: neighborhood.id
    )

    visit root_path
    click_link 'Sign Up'
    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Smith'
    fill_in 'Apartment Number', with: '1A'
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    select building.street, from: 'Building'
    select neighborhood.name, from: 'Neighborhood'

    click_button 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to have_content('Problems')
    expect(page).to have_content('Sign Out')
  end

  scenario 'provide invalid registration information' do
    visit root_path
    click_link 'Sign Up'

    click_button 'Sign up'
    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'password confirmation does not match password' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'passwodr'

    click_button 'Sign up'
    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content('Sign Out')
  end
end

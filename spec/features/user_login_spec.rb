require 'rails_helper'

RSpec.feature "Visitor navigates to Product Details", type: :feature, js: true do

  # SETUP
  before :each do
    @user = User.create! name: 'Test', email: 'test@test.com', password: 'password', password_confirmation: 'password'
  end

  scenario "User Login" do
    # ACT
    visit root_path
    click_on("Login")
    within(".dropdown-menu") do
      click_on("Login")
    end
    fill_in 'email', with: 'test@test.com'
    fill_in 'password', with: 'password'
    click_on("Submit")
    # VERIFY
    expect(page).to have_content "Test"
    save_screenshot

  end
end

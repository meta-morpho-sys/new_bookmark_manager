# frozen_string_literal: true

feature 'Destroying a session' do

  scenario 'a user can sign out' do
    User.create('test@example.com','password123')
    visit '/'
    click_link 'Sign in'

    fill_in('email', with: 'test@example.com')
    fill_in('password', with: 'password123')
    click_button 'Sign me in'

    click_button 'Sign out'
    expect(current_path).to eq '/'

    expect(page).not_to have_content 'Welcome, test@example.com'
    expect(page).to have_content 'You successfully signed out'
  end
end

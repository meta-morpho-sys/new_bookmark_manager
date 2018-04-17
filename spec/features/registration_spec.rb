# frozen_string_literal: true


feature 'Registration' do

  scenario 'a user can sign up' do
    visit '/'
    click_link 'Sign up'

    fill_in('email', with: 'test@example.com')
    fill_in('password', with: 'password123')
    click_button 'Sign me up'

    expect(page).to have_content 'Welcome, test@example.com'
  end
end

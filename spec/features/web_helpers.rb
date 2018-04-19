# frozen_string_literal: true

def fill_in_and_add
  fill_in 'url', with: 'https://www.testbookmark.com'
  fill_in 'title', with: 'Test title'
  click_button 'Add'
end

def login(user)
  visit '/'
  click_link 'Sign in'
  expect(current_path).to eq '/sessions/new'

  fill_in('email', with: user.email)
  fill_in('password', with: 'password123')
  click_button 'Sign me in'
end

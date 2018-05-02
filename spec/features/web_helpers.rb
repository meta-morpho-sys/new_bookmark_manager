# frozen_string_literal: true

def fill_in_and_add
  fill_in 'url', with: 'https://www.testbookmark.com'
  fill_in 'title', with: 'Test title'
  click_button 'Add'
end

def login(user)
  visit '/'
  click_link 'Sign in'
  expect(current_path).to eq '/login'

  fill_in('email', with: user.email)
  fill_in('password', with: 'password123')
  click_button 'Sign me in'
end

def add_tag(bookmark)
  within "#bookmark-#{bookmark.id}" do
    click_link 'Add tag'
  end

  expect(current_path).to eq "/bookmarks/#{bookmark.id}/tags"

  fill_in(:content, with: 'Fun')
  click_button 'Submit'
end

# frozen_string_literal: true

def fill_in_and_add
  fill_in 'url', with: 'https://www.testbookmark.com'
  fill_in 'title', with: 'Test title'
  click_button 'Add'
end

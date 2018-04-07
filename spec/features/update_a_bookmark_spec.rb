# frozen_string_literal: true

require 'pry'

feature 'Updating a bookmark' do
  scenario 'a user can modify the title and the url of an existing bookmark' do
    visit '/'

    within '#bookmark-3' do
      click_button 'Edit'
    end

    expect(current_path).to eq '/bookmarks/edit'

    fill_in 'new_url', with: 'https://www.google.co.uk'
    fill_in 'new_title', with: 'Google'

    # binding.pry
    click_button 'Confirm the edit'


    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_content 'Recipes'
    expect(page).to have_content 'Google'
  end
end

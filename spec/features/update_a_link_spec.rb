# frozen_string_literal: true

require 'pry'

feature 'Updating a link' do
  scenario 'a user can modify the title and the url of an existing link' do
    visit '/'

    within '#link-3' do
      click_button 'Edit'
    end

    expect(current_path).to eq '/links/edit'

    fill_in 'new_url', with: 'https://www.google.co.uk'
    fill_in 'new_title', with: 'Google'

    # binding.pry
    click_button 'Confirm the edit'


    expect(current_path).to eq '/links'
    expect(page).not_to have_content 'Recipes'
    expect(page).to have_content 'Google'
  end
end

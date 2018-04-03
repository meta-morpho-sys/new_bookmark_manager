# frozen_string_literal: true

feature 'Updating a link' do
  scenario 'a user can modify the url of an existing link' do
    visit '/'
    within '#link-3' do
      click_button 'Update'
    end

    expect(current_path).to eq '/update_link'
    fill_in 'url', with: 'https://www.google.co.uk'
    fill_in 'title', with: 'Google'
    click_button 'Confirm the update'

    expect(page).not_to have_link 'Recipes'
    expect(page).to have_content 'Google'
  end
end

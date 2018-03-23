# frozen_string_literal: true

feature 'Adding links' do
  scenario 'the user can add a link to Bookmark Manager' do
    visit '/add-a-new-link'
    fill_in 'url', with: 'https://www.testlink.com'
    click_button 'Add'
    expect(page).to have_content 'https://www.testlink.com'
  end
end

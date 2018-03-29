# frozen_string_literal: true

feature 'Adding links' do
  scenario 'the user can add a link to Bookmark Manager' do
    visit '/'
    fill_in 'url', with: 'https://www.testlink.com'
    click_button 'Add'
    expect(page).to have_content 'https://www.testlink.com'
  end

  scenario 'only valid urls can be added' do
    visit '/'
    fill_in 'url', with: 'not a real link'
    click_button 'Add'

    expect(page).not_to have_content 'not a real link'
    expect(page).to have_content 'You must submit a valid URL'
  end
end

# frozen_string_literal: true

feature 'Adding links' do
  scenario 'the user can add a link to Bookmark Manager' do
    visit '/'
    fill_in 'url', with: 'https://www.testlink.com'
    fill_in 'title', with: 'Test title'
    click_button 'Add'
    expect(page).to have_link(href: 'https://www.testlink.com')
    expect(page).to have_content 'Test title'
  end

  scenario 'only valid urls can be added' do
    visit '/'
    fill_in 'url', with: 'not a real link'
    fill_in 'title', with: 'not a real link'
    click_button 'Add'

    expect(page).not_to have_link 'not a real link'
    expect(page).to have_content 'You must submit a valid URL'
  end

  scenario 'title duplications are not allowed' do
    visit '/'

    fill_in 'url', with: 'https://www.testlink.com'
    fill_in 'title', with: 'Test title'
    click_button 'Add'
    expect(current_path).to eq '/'

    fill_in 'url', with: 'https://www.new_testlink.com'
    fill_in 'title', with: 'Test title'
    click_button 'Add'
    expect(page).to have_content 'That title is already taken, choose another.'
  end
end

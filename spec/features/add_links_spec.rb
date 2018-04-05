# frozen_string_literal: true

feature 'Adding links' do
  before { visit '/' }
  context 'adding real links' do
    scenario 'the user can add a link to Bookmark Manager' do
      fill_in_and_add
      expect(page).to have_link(href: 'https://www.testlink.com')
      expect(page).to have_content 'Test title'
    end

    scenario 'title duplications are not allowed' do
      fill_in_and_add
      expect(current_path).to eq '/'

      fill_in_and_add
      expect(page).to have_content 'That title is already taken, choose another.'
    end
  end

  scenario 'only valid urls can be added' do
    fill_in 'url', with: 'not a real link'
    fill_in 'title', with: 'not a real link'
    click_button 'Add'

    expect(page).not_to have_link 'not a real link'
    expect(page).to have_content 'You must submit a valid URL'
  end
end

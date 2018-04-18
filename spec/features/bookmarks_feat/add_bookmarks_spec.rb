# frozen_string_literal: true

feature 'Adding bookmarks' do
  before { visit '/bookmarks' }
  context 'adding real bookmarks' do
    scenario 'the user can add a bookmark to Bookmark Manager' do
      fill_in_and_add
      expect(page).to have_content 'Test title'
    end

    scenario 'title duplications are not allowed' do
      fill_in_and_add
      expect(current_path).to eq '/user/:id/bookmarks'

      fill_in_and_add
      expect(page).to have_content 'That title is already taken, choose another.'
    end
  end

  scenario 'only valid urls can be added' do
    fill_in 'url', with: 'not a real bookmark'
    fill_in 'title', with: 'not a real bookmark'
    click_button 'Add'

    expect(page).not_to have_content 'not a real bookmark'
    expect(page).to have_content 'You must submit a valid URL'
  end
end

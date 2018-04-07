# frozen_string_literal: true

feature 'Viewing comments' do
  scenario 'A user can see comments to a bookmark' do
    visit '/bookmarks'

    within '#bookmark-1' do
      click_button 'View comments'
    end

    expect(current_path).to eq '/bookmarks/comments'
    expect(page).to have_content 'Great bookmark'
    expect(page).to have_content 'Very useful'
  end
end

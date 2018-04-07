# frozen_string_literal: true

feature 'Deleting a bookmark' do
  scenario 'user can delete a bookmark' do
    visit '/'
    within '#bookmark-1' do
      click_button 'Delete'
    end
    expect(current_path).to eq '/bookmarks'
    expect(page).to have_content 'bookmark Doggy was successfully deleted!'
  end
end

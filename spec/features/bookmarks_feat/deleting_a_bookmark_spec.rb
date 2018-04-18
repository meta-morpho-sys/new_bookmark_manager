# frozen_string_literal: true

feature 'Deleting a bookmark' do
  scenario 'user can delete a bookmark' do
    bm = Bookmark.create('https://online.lloydsbank.co.uk', 'Lloyds')
    visit '/bookmarks'
    within "#bookmark-#{bm.id}" do
      click_button 'Delete'
    end
    expect(current_path).to eq '/user/:id/bookmarks'
    expect(page).to have_content 'Bookmark **Lloyds** was successfully deleted!'
  end
end

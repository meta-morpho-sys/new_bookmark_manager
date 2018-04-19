# frozen_string_literal: true

feature 'Deleting a bookmark' do
  scenario 'user can delete a bookmark' do
    user = User.create('test@example', 'password123')
    bm = Bookmark.create('https://online.lloydsbank.co.uk', 'Lloyds', user.id)
    login user

    expect(current_path).to eq "/user/#{user.id}/bookmarks"

    within "#bookmark-#{bm.id}" do
      click_button 'Delete'
    end

    expect(current_path).to eq "/user/#{user.id}/bookmarks"
    expect(page).to have_content 'Bookmark **Lloyds** was successfully deleted!'
  end
end

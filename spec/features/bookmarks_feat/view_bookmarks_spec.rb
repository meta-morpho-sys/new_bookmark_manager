# frozen_string_literal: true

feature 'Viewing bookmarks' do
  scenario 'A user can see bookmarks' do
    user = User.create('test@example', 'password123')

    login user

    Bookmark.create('https://online.lloydsbank.co.uk', 'Lloyds', user.id)
    click_button 'Add'
    Bookmark.create('https://online.barkley.co.uk', 'Barkley', user.id)
    click_button 'Add'
    expect(current_path).to eq "/user/#{user.id}/bookmarks"

    expect(page).to have_content 'Lloyds'
    expect(page).to have_content 'Barkley'
  end
end

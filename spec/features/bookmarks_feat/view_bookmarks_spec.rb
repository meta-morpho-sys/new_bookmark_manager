# frozen_string_literal: true

feature 'Viewing bookmarks' do
  scenario 'A user can see bookmarks' do
    user = User.create('test@example', 'password123')

    login user

    Bookmark.create('https://online.lloydsbank.co.uk', 'Lloyds', user.id)
    click_button 'Add'
    expect(page).to have_content 'Lloyds'
  end
end

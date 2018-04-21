# frozen_string_literal: true

require 'bcrypt'

feature 'User adds a bookmark' do

  scenario 'a specific BM is added to a specific user account' do

    user1 = User.create('test@example.com', 'password123')

    login(user1)

    expect(current_path).to eq "/user/#{user1.id}/bookmarks"

    Bookmark.create('https://online.lloydsbank.co.uk', 'Lloyds', user1.id)

    click_button 'Add'

    expect(page).to have_content 'Lloyds'
  end

  scenario "a user can't see other user's bookmarks" do
    user1 = User.create('test@example.com', 'password123')
    user2 = User.create('test2@example.com', 'password123')

    login(user1)
    visit "/user/#{user1.id}/bookmarks"
    Bookmark.create('https://online.lloydsbank.co.uk', 'Lloyds', user1.id)
    click_button 'Add'

    expect(page).to_not have_content 'Barkley'
    expect(page).to have_content 'Lloyds'

    login(user2)
    visit "/user/#{user2.id}/bookmarks"
    Bookmark.create('https://online.barkley.co.uk', 'Barkley', user2.id)
    click_button 'Add'

    expect(page).to have_content 'Barkley'
    expect(page).not_to have_content 'Lloyds'
  end
end

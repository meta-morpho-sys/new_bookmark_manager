# frozen_string_literal: true

feature 'Viewing bookmarks' do
  scenario 'A user can see all bookmarks' do
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


  scenario 'a user can see only his bookmarks when filtered by tag' do
    user = User.create('test@example', 'password123')
    another_user = User.create('another_user@example', 'password123')

    bm = Bookmark.create('https://www.netflix.com', 'Netflix', user.id)
    another_bm = Bookmark.create('https://www.odeon.com', 'Odeon', another_user.id)

    tag = Tag.create 'Movies and fun'

    BookmarkTag.create(bm.id, tag.id)
    BookmarkTag.create(another_bm.id, tag.id)

    login user

    within "#bookmark-#{bm.id}" do
      click_link 'Movies and fun'
    end

    expect(current_path).to eq "/tags/#{tag.id}/bookmarks"
    expect(page).not_to have_content 'Odeon'
    expect(page).to have_content 'Netflix'
  end
end

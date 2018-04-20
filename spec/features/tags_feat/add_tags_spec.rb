# frozen_string_literal: true

feature 'Creating a tag for a bookmark' do
  scenario 'anyone can tag a bm' do
    user = User.create('test@example', 'password123')
    bm = Bookmark.create('https://www.netflix.com', 'Neflix', user.id)
    login user

    within "#bookmark-#{bm.id}" do
      click_link 'Add tag'
    end

    expect(current_path).to eq "/bookmarks/#{bm.id}/tags"
    expect(page).to have_content 'Bookmark: Neflix'

    fill_in(:content, with: 'Fun')
    click_button 'Submit'

    expect(page).to have_content '**Fun** tag successfully created!'

    within "#bookmark-#{bm.id}" do
      expect(page).to have_content 'Fun'
    end
  end

  scenario 'anyone can see the bookmarks filtered by tag' do
    user = User.create('test@example', 'password123')
    bm = Bookmark.create('https://www.netflix.com', 'Neflix', user.id)
    tag = Tag.create 'Movies and fun'
    BookmarkTag.create(bm.id, tag.id)
    login user

    # within "#bookmark-#{tag.id}" do
    #   click_link 'Movies and fun'
    # end

    within "#bookmark-#{bm.id}" do
      click_link 'Movies and fun'
    end

    expect(current_path).to eq "/tags/#{tag.id}/bookmarks"
    expect(page).to have_content 'Netflix'
  end
end

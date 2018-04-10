# frozen_string_literal: true

feature 'Viewing comments' do
  scenario 'A user can see comments to a bookmark' do
    bm = Bookmark.create('https://online.lloydsbank.co.uk', 'Lloyds')
    Comment.create('Great bookmark', bm.id)
    Comment.create('Very useful', bm.id)

    visit '/bookmarks'

    within "#bookmark-#{bm.id}" do
      click_button 'View'
    end

    expect(current_path).to eq '/bookmark/comments'
    expect(page).to have_content 'Great bookmark'
    expect(page).to have_content 'Very useful'
  end
end

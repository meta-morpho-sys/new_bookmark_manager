# frozen_string_literal: true

feature 'Viewing comments' do
  scenario 'A user can see comments to a bookmark' do
    user = User.create('test@example', 'password123')
    bm = Bookmark.create('https://online.lloydsbank.co.uk', 'Lloyds', user.id)
    login user
    Comment.create('Great bookmark', bm.id)
    Comment.create('Very useful', bm.id)

    within "#bookmark-#{bm.id}" do
      click_link 'View'
    end

    expect(current_path).to eq "/bookmark/#{bm.id}/comments/view"
    expect(page).to have_content 'Bookmark: Lloyds'

    expect(page).to have_content 'Great bookmark'
    expect(page).to have_content 'Very useful'
  end
end

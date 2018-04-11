# frozen_string_literal: true

feature 'Commenting on a bookmark' do
  scenario 'anyone can comment on a bookmark' do
    bm = Bookmark.create('https://online.lloydsbank.co.uk', 'Lloyds')
    visit '/bookmarks'

    within "#bookmark-#{bm.id}" do
      click_button 'Comment'
    end

    expect(current_path).to eq '/bookmarks/comments'
    expect(page).to have_content 'Bookmark: Lloyds'

    fill_in(:text, with: 'This is a test comment')
    click_button 'Submit'

    within "#bookmark-#{bm.id}" do
      click_button 'View'
    end
    expect(page).to have_content 'This is a test comment'
  end
end

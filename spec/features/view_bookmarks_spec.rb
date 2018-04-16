# frozen_string_literal: true

feature 'Viewing bookmarks' do
  scenario 'A user can see bookmarks' do
    visit '/bookmarks'
    Bookmark.create('https://online.lloydsbank.co.uk', 'Lloyds')
    click_button 'Add'
    expect(page).to have_content 'Lloyds'
  end
end

# frozen_string_literal: true

feature 'Creating a tag for a bookmark' do

  scenario 'anyone can tag a bm' do
    bm = Bookmark.create('https://www.netflix.com', 'Neflix')
    visit '/bookmarks'

    within "#bookmark-#{bm.id}" do
      click_button 'Tag'
    end

    expect(current_path).to eq '/bookmarks/tags'
    expect(page).to have_content 'Bookmark: Neflix'

    fill_in(:content, with: 'Fun')
    click_button 'Submit'

    expect(page).to have_content "'Fun' tag successfully created!"
  end
end

# frozen_string_literal: true

feature 'Tags are unique' do
  scenario 'a tag can have one name only' do
    user = User.create('test@example', 'password123')
    bm = Bookmark.create('https://www.netflix.com', 'Neflix', user.id)
    login user

    2.times {
      within "#bookmark-#{bm.id}" do
        click_link 'Add tag'
      end

      expect(current_path).to eq "/bookmarks/#{bm.id}/tags"
      expect(page).to have_content 'Bookmark: Neflix'

      fill_in(:content, with: 'Fun')
      click_button 'Submit'
    }
    expect(page).to have_content 'This tag already exists!When you are done\
 with the logic take me and my test out, please!!!'
  end
end

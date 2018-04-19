# frozen_string_literal: true

feature 'Updating a bookmark' do
  scenario 'a user can modify the title and the url of an existing bookmark' do
    user = User.create('test@example', 'password123')
    bm = Bookmark.create('https://online.lloydsbank.co.uk', 'Lloyds', user.id)

    login user

    within "#bookmark-#{bm.id}" do
      click_link 'Edit'
    end

    expect(current_path).to eq "/bookmarks/#{bm.id}/edit"

    fill_in 'new_url', with: 'https://www.google.co.uk'
    fill_in 'new_title', with: 'Google'

    click_button 'Confirm the edit'

    expect(current_path).to eq "/user/#{user.id}/bookmarks"
    expect(page).not_to have_content 'Lloyds'
    expect(page).to have_content 'Google'
  end
end

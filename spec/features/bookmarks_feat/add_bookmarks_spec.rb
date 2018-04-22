# frozen_string_literal: true

require './lib/msg_strings'

feature 'Adding bookmarks' do
  before(:each) do
    user = User.create('test@example.com', 'password123')
    login(user)
  end

  context 'adding real bookmarks' do
    scenario 'the user can add a bookmark to Bookmark Manager' do
      fill_in_and_add
      expect(page).to have_content 'Test title'
    end

    scenario 'title duplications are not allowed' do
      user = User.create('test2@example.com', 'password123')
      login(user)

      fill_in_and_add
      fill_in_and_add
      expect(page).to have_content MsgStrings::DUPLICATE_TITLE
    end
  end


  scenario 'only valid urls can be added' do
    fill_in 'url', with: 'not a real bookmark'
    fill_in 'title', with: 'not a real bookmark'
    click_button 'Add'

    expect(page).not_to have_content 'not a real bookmark'
    expect(page).to have_content MsgStrings::VALID_URL
  end
end

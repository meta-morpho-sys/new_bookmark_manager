# frozen_string_literal: true

feature 'Commenting on a bookmark' do
  scenario 'anyone can comment on a bookmark' do
    visit '/bookmarks'

    within '#bookmark-1' do
      click_button 'Comment'
    end

    fill_in(:text, with: 'This is a test comment')
    click_button 'Submit'

    within '#bookmark-1' do
      click_button 'View comments'
    end
    expect(page).to have_content 'This is a test comment'
  end
end

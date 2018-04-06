# frozen_string_literal: true

feature 'Viewing comments' do
  scenario 'A user can see comments to a link' do
    visit '/links'

    within '#link-1' do
      click_button 'View comments'
    end

    expect(current_path).to eq '/links/comments'
    expect(page).to have_content 'Great link'
    expect(page).to have_content 'Very useful'
  end
end

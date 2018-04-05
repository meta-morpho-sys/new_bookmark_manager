# frozen_string_literal: true

feature 'Deleting a link' do
  scenario 'user can delete a link' do
    visit '/'
    within '#link-1' do
      click_button 'Delete'
    end
    expect(current_path).to eq '/links'
    expect(page).to have_content 'Link Doggy was successfully deleted!'
  end
end

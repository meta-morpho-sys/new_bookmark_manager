# frozen_string_literal: true

feature 'Viewing bookmarks' do
  scenario 'A user can see bookmarks' do
    visit '/'
    expect(page).to have_content 'Lloyds'
    expect(page).to have_content 'Doggy'
    expect(page).to have_content 'Recipes'
  end
end

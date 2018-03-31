# frozen_string_literal: true

feature 'Viewing links' do
  scenario 'A user can see links' do
    visit '/'
    expect(page).to have_content 'Lloyds'
    expect(page).to have_content 'Doggy'
    expect(page).to have_content 'Recipes'
  end
end

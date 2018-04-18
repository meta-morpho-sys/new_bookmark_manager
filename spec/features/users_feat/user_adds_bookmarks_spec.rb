# frozen_string_literal: true

feature 'User adds a bookmark' do

  scenario 'a specific BM is added to a specific user account' do
    user = User.create('test@example.com', 'password123')

    visit '/sessions/new'

    fill_in('email', with: 'test@example.com')
    fill_in('password', with: 'password123')

    click_button 'Sign me in'

    expect(current_path).to eq "/user/#{user.id}/bookmarks"


    # expect().to

  end
end

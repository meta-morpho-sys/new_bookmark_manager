# frozen_string_literal: true


feature 'Creating a new session' do

  scenario 'a user can sign in' do
    User.create('test@example.com','password123')
    visit '/'
    click_link 'Sign in'

    expect(current_path).to eq '/sessions/new'

    fill_in('email', with: 'test@example.com')
    fill_in('password', with: 'password123')
    click_button 'Sign me in'

    expect(page).to have_content 'Welcome, test@example.com'
  end

  scenario "a user can't sign in if email is incorrect" do
    User.create('test@example.com','password123')
    visit '/'
    click_link 'Sign in'

    fill_in('email', with: 'wrong_mail@example.com')
    fill_in('password', with: 'password123')
    click_button 'Sign me in'

    expect(page).not_to have_content 'Welcome, test@example.com'
    expect(page).to have_content 'You must have entered a wrong email!'
  end
end

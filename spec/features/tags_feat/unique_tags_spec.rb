# frozen_string_literal: true

feature 'Tags are unique' do
  scenario 'a tag can have one name only' do
    user = User.create('test@example', 'password123')
    bm1 = Bookmark.create('https://www.netflix.com', 'Neflix', user.id)
    bm2 = Bookmark.create('https://www.odeon.com', 'Odeon', user.id)

    login user
    add_tag(bm1)
    add_tag(bm2)

    expect(page).to have_content "'Fun' tag successfully assigned"
  end

  scenario 'the same tag can be assigned only once to the same bm' do
    user = User.create('test@example', 'password123')
    bm1 = Bookmark.create('https://www.netflix.com', 'Neflix', user.id)

    login user
    add_tag(bm1)
    add_tag(bm1)

    expect(page).to have_content 'Fun'
    expect(page).to have_content 'This tag has been already assigned'
  end
end

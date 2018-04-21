# frozen_string_literal: true

feature 'Tags are unique' do
  scenario 'a tag can have one name only' do
    user = User.create('test@example', 'password123')
    bm = Bookmark.create('https://www.netflix.com', 'Neflix', user.id)
    bm2 = Bookmark.create('https://www.odeon.com', 'Odeon', user.id)

    login user
    add_tag(bm)
    add_tag(bm2)

    expect(page).to have_content "'Fun' tag successfully assigned"
  end
end

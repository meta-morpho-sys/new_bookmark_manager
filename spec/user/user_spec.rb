# frozen_string_literal: true

require_relative '../../models/user'

describe User do
  describe '.all' do
    it 'returns all users wrapped in user instances' do
      user1 = User.create('unit@test1.com', 'pswd123')
      user2 = User.create('unit@test2.com', 'pswd456')
      expect(User.all.map(&:id)).to include user1.id, user2.id
    end
  end

  describe '.create' do
    it 'adds a new user' do
      user = User.create('unit@test.com', 'pswd123')
      expect(user.id).not_to be nil
    end

    it "encrypts user's password" do
      expect(BCrypt::Password).to receive(:create).with('pswd123').and_return 'blah'
      User.create('unit@test.com', 'pswd123')
    end
  end

  describe '.find' do
    it 'finds user by ID' do
      user = User.create('unit@test1.com', 'pswd123')
      expect(User.find(user.id).email).to eq 'unit@test1.com'
    end

    it 'returns nil if no ID is given' do
      expect(User.find(nil)).to eq nil
    end
  end

  describe '.authenticate' do
    example 'the user gives correct email and password' do
      user = User.create('unit@test1.com', 'pswd123')
      authenticated_user = User.authenticate('unit@test1.com', 'pswd123')
      expect(authenticated_user.email).to eq 'unit@test1.com'
      expect(authenticated_user.id).to eq user.id
    end

    example 'returns nil if the user gives incorrect email' do
      User.create('unit@test1.com', 'pswd123')
      expect(User.authenticate('wrong_email@test1.com', 'pswd123')).to be_nil
    end

    example 'returns nil if the user gives incorrect password' do
      User.create('unit@test1.com', 'pswd123')
      expect(User.authenticate('unit@test1.com', 'wrong_password')).to be_nil
    end
  end

  describe '#bookmarks' do
    it 'returns all the BMs associated with that particular user ID' do
      user1 = User.create('unit@test1.com', 'pswd123')
      user2 = User.create('unit@test2.com', 'pswd456')
      bm1 = Bookmark.create('https://odeon.com', 'Cinema', user1.id)
      bm2 = Bookmark.create('https://netflix.com', 'Netflix', user2.id)

      expect(user1.bookmarks).to include bm1
      expect(user1.bookmarks).not_to include bm2
      expect(user2.bookmarks).to include bm2
      expect(user2.bookmarks).not_to include bm1
    end
  end

  describe '#bookmarks_per_tag' do
    it 'returns all the BMs associated with that particular tag content' do
      user = User.create('unit@test1.com', 'pswd123')
      user2 = User.create('unit@test2.com', 'pswd456')

      bm1 = Bookmark.create('https://odeon.com', 'Cinema', user.id)
      bm2 = Bookmark.create('https://netflix.com', 'Netflix', user.id)
      bm3 = Bookmark.create('https://youtube.com', 'Youtube', user2.id)

      tag = Tag.create('Fun')

      BookmarkTag.create(bm1.id, tag.id)
      BookmarkTag.create(bm2.id, tag.id)
      BookmarkTag.create(bm3.id, tag.id)

      expect(user.bookmarks_per_tag(tag.content)).to include bm1, bm2
      expect(user.bookmarks_per_tag(tag.content)).not_to include bm3
      expect(user2.bookmarks_per_tag(tag.content)).to include bm3
      expect(user2.bookmarks_per_tag(tag.content)).not_to include bm1, bm2
    end
  end
end

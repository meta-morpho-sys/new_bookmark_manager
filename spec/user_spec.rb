# frozen_string_literal: true

require_relative '../models/user'

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
      expect(BCrypt::Password).to receive(:create).with('pswd123')
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
end

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    User.destroy_all
  end

  context 'validations' do
    it 'is valid with valid attributes' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'is not valid without an email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'is not valid with an improperly formatted email' do
      user = build(:user, email: 'invalid_email')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("is invalid")
    end

    it 'is not valid with a duplicate email' do
      create(:user, email: 'duplicate@example.com')
      user = build(:user, email: 'duplicate@example.com')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("has already been taken")
    end

    it 'is not valid without a password' do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'is not valid when password and password_confirmation do not match' do
      user = build(:user, password: 'password', password_confirmation: 'different_password')
      expect(user).not_to be_valid
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'is not valid with a short password' do
      user = build(:user, password: 'short', password_confirmation: 'short')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
  end

  context 'email uniqueness' do
    it 'is case insensitive' do
      create(:user, email: 'test@example.com')
      duplicate_user = build(:user, email: 'TEST@example.com')

      expect(duplicate_user).not_to be_valid
      expect(duplicate_user.errors[:email]).to include("has already been taken")
    end
  end

  context 'password encryption' do
    it 'encrypts the password' do
      user = create(:user, password: 'password', password_confirmation: 'password')
      expect(user.password_digest).not_to be_nil
    end
  end
end

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
    it { is_expected.to have_secure_password }

    it 'is not valid with an improperly formatted email' do
      invalid_emails = ['user@foo,com', 'user_at_foo.org', 'example.user@foo.']
      invalid_emails.each do |invalid_email|
        user = build(:user, email: invalid_email)
        expect(user).not_to be_valid
        expect(user.errors[:email]).to include("is invalid")
      end
    end

    it 'is valid with a properly formatted email' do
      valid_emails = ['user@foo.COM', 'A_US-ER@foo.bar.org', 'first.last@foo.jp', 'alice+bob@baz.cn']
      valid_emails.each do |valid_email|
        user = build(:user, email: valid_email)
        expect(user).to be_valid
      end
    end

    it 'is not valid without matching password confirmation' do
      user = build(:user, password: 'password123', password_confirmation: 'different')
      expect(user).not_to be_valid
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'is not valid with a short password' do
      user = build(:user, password: 'short', password_confirmation: 'short')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
  end
end

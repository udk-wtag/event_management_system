RSpec.describe UsersController, type: :controller do

  it do
    params = {
      user: {
        name: 'John Doe',
        email: 'johndoe@example.com',
        password: 'password'
      }
    }
    is_expected.to permit(:name, :email, :password).for(:create, params: params).on(:user)
  end
end

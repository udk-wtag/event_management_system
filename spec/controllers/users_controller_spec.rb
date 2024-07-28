RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) do
    {
      name: FFaker::Name.name,
      email: FFaker::Internet.email,
      password: 'password',
      password_confirmation: 'password'
    }
  end

  let(:invalid_attributes) do
    {
      name: '',
      email: 'invalid_email',
      password: 'short',
      password_confirmation: 'mismatch'
    }
  end

  let!(:user) { create(:user) }

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns all users to @users' do
      get :index
      expect(assigns(:users)).to eq([user])
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: user.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new User' do
        expect {
          post :create, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it 'redirects to the created user' do
        post :create, params: { user: valid_attributes }
        expect(response).to redirect_to(User.last)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new User' do
        expect {
          post :create, params: { user: invalid_attributes }
        }.to change(User, :count).by(0)
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      get :edit, params: { id: user.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          name: FFaker::Name.name,
          email: FFaker::Internet.email,
          password: 'newpassword',
          password_confirmation: 'newpassword'
        }
      end

      it 'updates the requested user' do
        patch :update, params: { id: user.id, user: new_attributes }
        user.reload
        expect(user.name).to eq(new_attributes[:name])
        expect(user.email).to eq(new_attributes[:email])
      end

      it 'redirects to the user' do
        patch :update, params: { id: user.id, user: new_attributes }
        user.reload
        expect(response).to redirect_to(user)
      end
    end

    context 'with invalid parameters' do
      it 'does not update the user' do
        patch :update, params: { id: user.id, user: invalid_attributes }
        user.reload
        expect(user.name).not_to eq(invalid_attributes[:name])
        expect(user.email).not_to eq(invalid_attributes[:email])
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested user' do
      expect {
        delete :destroy, params: { id: user.id }
      }.to change(User, :count).by(-1)
    end

    it 'redirects to the root path' do
      delete :destroy, params: { id: user.id }
      expect(response).to redirect_to(root_path)
    end
  end
end

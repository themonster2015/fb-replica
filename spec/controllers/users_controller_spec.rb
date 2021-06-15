# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#show' do
    let(:user) { FactoryBot.create(:user) }

    context 'as an authenticated user' do
      before { sign_in user }
      it 'responds successfully' do
        get :show, params: { id: user.id }
        expect(response).to be_successful
        expect(assigns(:user)).to eq(user)
      end
    end

    context 'as a guest' do
      before { get :show, params: { id: user.id } }
      it 'doesnt respond successfully' do
        expect(response).not_to be_successful
      end
      it 'redirects to sign in path' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#index' do
    let(:user) { FactoryBot.create(:user) }

    context 'as an authenticated user' do
      before { sign_in user }
      it 'responds successfully' do
        get :index
        expect(response).to be_successful
        expect(assigns(:users)).to eq(User.all - [user] - user.friends)
      end
    end

    context 'as a guest' do
      before { get :index }
      it 'doesnt respond successfully' do
        expect(response).not_to be_successful
      end
      it 'redirects to sign in path' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end

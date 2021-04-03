require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }

  describe '#' do
    it '正常にアクセスできること' do
      get users_path(user)
      expect(response).to have_http_status(302)
    end
  end

  describe '#new' do
    it '正常にアクセスできること' do
      get new_user_path(user)
      expect(response).to have_http_status(200)
    end
  end

  describe '#show' do
    it '正常にアクセスできること' do
      get user_path(user)
      expect(response).to have_http_status(302)
    end
  end

  describe '#edit' do
    it '正常にアクセスできること' do
      get edit_user_path(user)
      expect(response).to have_http_status(302)
    end
  end

  describe '#guest' do
    it '正常にアクセできること' do
      get guest_path(user)
      expect(response).to have_http_status(302)
    end
  end

  describe '#following_user' do
    it '正常にアクセできること' do
      get following_user_path(user)
      expect(response).to have_http_status(302)
    end
  end

  describe '#followers_user' do
    it '正常にアクセできること' do
      get followers_user_path(user)
      expect(response).to have_http_status(302)
    end
  end
end

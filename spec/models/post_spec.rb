require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#create' do
    let(:post) { build(:post) }

    context '投稿を保存できる場合' do
      it '正しく保存できること' do
        example_post = FactoryBot.create(:post)
        expect(example_post).to be_valid
      end
    end

    context '投稿を保存できない場合' do
      it 'タイトルが空欄だと保存できないこと' do
        post.title = ''
        expect(post).to be_invalid
      end

      it 'タイトルが30文字以上だと保存できないこと' do
        post.title = 'a' * 31
        expect(post).to be_invalid
      end

      it '詳細が空欄だと保存できないこと' do
        post.content = ''
        expect(post).to be_invalid
      end

      it '詳細が200文字以上だと保存できないこと' do
        post.content = 'a' * 200
        expect(post).to be_invalid
      end

      it 'isuueが未入力だと保存できないこと' do
        post.issue = ''
        expect(post).to be_invalid
      end

      it '画像が未入力だと保存できないこと' do
        post.image = ''
        expect(post).to be_invalid
      end

      it 'レビューが未入力だと保存できないこと' do
        post.review = ''
        expect(post).to be_invalid
      end
    end
  end

  describe '#liked_by' do
    before do
      @post = FactoryBot.create(:post)
      @user = FactoryBot.create(:user)
    end

    context 'ユーザが投稿にいいね済みの場合' do
      it 'trueを返すこと' do
        like = FactoryBot.build(:like, post: @post, user: @user)
        like.save!
        expect(@post.liked_by(@user)).to eq true
      end
    end

    context 'ユーザが投稿にいいねしてない場合' do
      it 'falseを返すこと' do
        like = FactoryBot.build(:like, post: @post)
        like.save!
        expect(@post.liked_by(@user)).to eq false
      end
    end
  end

   describe '#create_notification_like' do
    before do
      @post = FactoryBot.create(:post)
      @current_user = FactoryBot.create(:user)
      @visited = FactoryBot.create(:user)
    end

    context 'ユーザが既に通知を受けていた場合' do
      it 'レコードが保存されないこと' do
        Notification.create(visitor: @current_user, visited: @visited, post: @post, action: 'like')
        @post.create_notification_like(@current_user)
        expect(@current_user.passive_notifications.count).to eq 0
      end
    end

    context 'ユーザが通知を受けておらず、かつ送信者と受信者が同じユーザでない場合' do
      it 'レコードが保存されること' do
        @post.create_notification_like(@current_user)
        expect(@current_user.active_notifications.count).to eq 1
      end
    end
  end
end

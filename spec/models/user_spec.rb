require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'create' do
    context 'userを登録できる場合' do
      let(:user) {build(:user)}

      it '全ての入力が正常の場合、登録できること' do
        expect(user).to be_valid
      end

      it '名前が15文字以内だと保存できること' do
        user.name = 'a' *15
        expect(user).to be_valid
      end

      it 'メールアドレスが255文字以内だと保存できること' do
        user.email = "aaaaa@#{ 'a' * 245}.com"
        expect(user).to be_valid
      end

      it '有効なメールフォーマットだと保存できること' do
        valid_addresses = %w(user@example.com USER@foo.COM A_US-ER@foo.bar.org
                            first.last@foo.jp alice+bob@baz.cn)
        valid_addresses.each do |valid_address|
          user.email = valid_address
          expect(user).to be_valid
        end
      end

      it 'パスワードが6文字以上だと保存できること' do
        user.password = 'aaaaaa'
        user.password_confirmation = 'aaaaaa'
        expect(user).to be_valid
      end
    end

    context 'userを登録できない場合' do
      let(:user) { build(:user) }

      it '名前がなければ保存できないこと' do
        user.name = ''
        expect(user).to be_invalid
      end

      it '名前が16文字以上だと保存できないこと' do
        user.name = 'a' * 16
        expect(user).to be_invalid
      end

      it 'メールアドレスが空欄だと保存できないこと' do
        user.email = ''
        expect(user).to be_invalid
      end

      it 'メールアドレスが256文字以上だと保存できないこと' do
        user.email = "aaaaa@#{ 'a' * 246}.com"
        expect(user).to be_invalid
      end

      it '重複したメールアドレスがあれば保存できないこと' do
        duplicate_user = user.dup
        user.save
        expect(duplicate_user).to be_invalid
      end

      it '無効なメールフォーマットだと保存できないこと' do
        invalid_addresses = %w(user@example,com user_at_foo.org user.name@example.
                          foo@bar_baz.com foo@bar+baz.com)
        invalid_addresses.each do |invalid_address|
          user.email = invalid_address
          expect(user).to be_invalid
        end
      end

      it 'パスワードが空欄だと保存できないこと' do
        user.password = ''
        user.password_confirmation = ''
        expect(user).to be_invalid
      end

      it 'パスワード確認が空欄だと保存できないこと' do
        user.password_confirmation = ''
        expect(user).to be_invalid
      end

      it 'パスワードが6文字以下だと保存できないこと' do
        user.password = 'a' * 5
        expect(user).to be_invalid
      end

      it 'パスワードとパスワード確認が違うと保存できないこと' do
        user.password_confirmation = 'a' * 6
        expect(user).to be_invalid
      end
    end
  end

  describe "follow と unfollow" do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    before { user.follow(other_user) }

    context "他のユーザーをフォローする場合" do
      it "フォローが保存できること" do
        expect(user.following?(other_user)).to be_truthy
      end
    end

    context "他のユーザーのフォローを解除する場合" do
      it "フォロー解除が保存できること" do
        user.unfollow(other_user)
        expect(user.following?(other_user)).to be_falsy
      end
    end
  end
end

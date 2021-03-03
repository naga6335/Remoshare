require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe '#create' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:notification) {
      build(
        :notification,
        visitor_id: user1.id,
        visited_id: user2.id
      )
    }

    describe '正常に保存できる場合' do
      describe 'likeに関するテスト' do
        it 'likeを正常に保存できること' do
          notification.action = 'like'
          expect(notification).to be_valid
        end
      end

      describe 'commentに関するテスト' do
        it 'commentを正常に保存できること' do
          notification.action = 'comment'
          expect(notification).to be_valid
        end
      end

      describe 'followに関するテスト' do
        it 'followを正常に保存できること' do
          notification.action = 'follow'
          expect(notification).to be_valid
        end
      end
    end

    describe '正常に保存できない場合' do
      it 'actionの文字列が指定したもの以外なら保存できないこと' do
        notification.action = 'aaa'
        expect(notification).to be_invalid
      end
    end
  end
end

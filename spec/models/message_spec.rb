require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#create' do
    let(:message) { create(:message) }

    context 'メッセージを保存できる場合' do
      it '正常に保存できること' do
        expect(message).to be_valid
      end

      it 'messageが200文字以内で保存できること' do
        message.message = 'a' * 200
        expect(message).to be_valid
      end

      it 'user_idが違えば同じroom_idで保存できること' do
        example_user = create(:user)
        example_message = build(:message,
                                user_id: example_user.id, room_id: message.room_id)
        expect(example_message).to be_valid
      end
    end

    context 'メッセージを保存できない場合' do
      it 'user_idがないと保存できないこと' do
        message.user_id = ''
        expect(message).to be_invalid
      end

      it 'room_idがないと保存できないこと' do
        message.room_id = ''
        expect(message).to be_invalid
      end

      it 'messageがないと保存できないこと' do
        message.message = ''
        expect(message).to be_invalid
      end

      it 'messageが200文字以上だと保存できないこと' do
        message.message = 'a' * 201
        expect(message).to be_invalid
      end
    end

    context '一意性のテスト' do
      it 'user_idとroom_idの組み合わせが一意であること' do
        example_message = build(:message)
        expect(example_message).to be_invalid
      end
    end
  end
end

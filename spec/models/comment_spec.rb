require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { create(:comment) }

  describe '#create' do
    context '保存できる場合' do

      it '入力が正しいこと' do
        expect(comment).to be_valid
      end

      it '1文字以上であれば保存できること' do
        comment.comment = 'a' * 1
        expect(comment).to be_valid
      end

      it '200文字以内であれば保存できること' do
        comment.comment = 'a' * 200
        expect(comment).to be_valid
      end
    end

    context '保存できない場合' do

      it '入力が空欄だと保存できない' do
        comment.comment = ''
        expect(comment).to be_invalid
      end

      it '201文字以上だと保存できない' do
        comment.comment = 'a' * 201
        expect(comment).to be_invalid
      end

      it 'post_idがnilだと保存できない' do
        comment.post_id = nil
        expect(comment).to be_invalid
      end

      it 'user_idがnilだと保存できない' do
        comment.user_id = nil
        expect(comment).to be_invalid
      end
    end
  end
end

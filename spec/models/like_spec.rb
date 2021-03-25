require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '#create' do
    context 'likeを保存できる場合' do
      let(:like) { create(:like) }

      it '正しく保存できること' do
        expect(like).to be_valid
      end

      it "post_idが同じでもuser_idが違こと" do
        expect(FactoryBot.create(:like, post_id: like.post_id)).to be_valid
      end

      it "user_idが同じでもpost_idが違うこと" do
        expect(FactoryBot.create(:like, user_id: like.user_id)).to be_valid
      end
    end

    context 'likeを保存できない場合' do
      let(:like) { create(:like) }

      it 'user_idが存在しないと保存できないこと' do
        like.user_id = ''
        expect(like).to be_invalid
      end

      it 'post_idが存在しないと保存できないこと' do
        like.post_id = ''
        expect(like).to be_invalid
      end
    end

    context '一意性の検証' do
      let(:like) { create(:like) }

      it 'post_idとuser_idの組み合わせは一意であること' do
        another_like = build(:like, user_id: like.user_id, post_id: like.post_id)
        expect(another_like).to be_invalid
      end
    end
  end
end

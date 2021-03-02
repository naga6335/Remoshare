require 'rails_helper'

RSpec.describe Relationship, type: :model do
 describe '#create' do
   let(:user) { create(:user) }
   let(:other_user) { create(:user) }

   context '正常に保存できる場合' do
     let(:relationship) {
       create(
       :relationship,
       follower_id: user.id,
       followed_id: other_user.id
       )
     }

      it 'relationshipを登録できること' do
        expect(relationship).to be_valid
      end
    end

    context '保存できない場合' do
      let(:relationship) {
        create(
          :relationship,
          follower_id: user.id,
          followed_id: other_user.id
        )
      }

      it 'follower_idが存在しないと保存できないこと' do
        relationship.follower_id = nil
        expect(relationship).to be_invalid
      end

      it 'followed_idが存在しないと保存できないこと' do
        relationship.followed_id = nil
        expect(relationship).to be_invalid
      end
    end
  end
end

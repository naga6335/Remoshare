require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe '#create' do
    let(:entry) { create(:entry) }

    context 'entry情報が保存できる場合' do
      it '正常に保存できること' do
        expect(entry).to be_valid
      end
    end

    context 'ebtry情報が保存できない場合' do
      it 'user_idがないと保存できないこと' do
        entry.user_id = ''
        expect(entry).to be_invalid
      end

      it 'room_idがないと保存できないこと' do
        entry.user_id = ''
        expect(entry).to be_invalid
      end
    end

    context '一意性のテスト' do
      let(:entry) { create(:entry) }

      it 'user_idとroom_idの組み合わせは一意であること' do
        example_entry = build(:entry, user_id: entry.user_id, room_id: entry.room_id)
        expect(example_entry).to be_invalid
      end
    end
  end
end

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
  end
end

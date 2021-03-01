require 'rails_helper'

RSpec.describe "UsersSignups", type: :system do
  scenario '新規登録情報に不備がある場合、登録できないこと' do
    visit signup_path
    fill_in '名前', with: ' '
    fill_in 'メールアドレス', with: 'aaaaa@example'
    fill_in 'パスワード', with: 'foo'
    fill_in 'パスワード確認', with: 'bar'
    click_on '登録する'
    aggregate_falures do
      expect(current_path).to eq user_path
      expect(page).to have_content '新規登録'
    end
  end
end

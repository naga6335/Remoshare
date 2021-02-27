RakutenWebService.configure do |c|
  # (必須) アプリケーションID
  #ここで検索エラーあり
  # c.application_id = Rails.application.credentials.rakuten[:api_key]

  # (任意) 楽天アフィリエイトID
  c.affiliate_id = '*******************'
end

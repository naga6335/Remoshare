RakutenWebService.configure do |c|
  c.application_id = Rails.application.credentials.rakuten[:api_key]

  # (任意) 楽天アフィリエイトID
  c.affiliate_id = '*******************'
end

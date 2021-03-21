class SearchForm
  include ActiveModel::Model
  attr_accessor :keyword

  validates :keyword, presence: true, length: { in: 2..30 }
end

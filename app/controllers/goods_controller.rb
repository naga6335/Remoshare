class GoodsController < ApplicationController

  def search
    if params[:keyword]
      goods = SearchForm.new(keyword: params[:keyword])
      if goods.valid?
        @goods = RakutenWebService::Ichiba::Item.search(keyword: goods.keyword)
      else
        flash[:alert] = "入力に誤りがあります"
        render 'search'
      end
    end
  end

end

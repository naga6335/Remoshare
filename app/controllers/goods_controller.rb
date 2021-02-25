class GoodsController < ApplicationController

  def search
    if params[:keyword]
    @goods = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    end
  end
end

class Public::HomesController < ApplicationController
  def top
    @genres = Genre.where(valid_invalid_status: 0) # ジャンルの有効無効ステータスが有効のものだけ探す/除外検索
    @items = Item.limit(4)
  end
end

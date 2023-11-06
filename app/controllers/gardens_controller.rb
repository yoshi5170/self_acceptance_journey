class GardensController < ApplicationController
  def show
    # 合計数を計算
    all_planted_flowers = current_user.planted_flowers.includes(:flower).order(added_at: :asc)
    @total_flowers_count = all_planted_flowers.count
    @weekly_flowers_count = all_planted_flowers.where("added_at >= ?", Time.current.beginning_of_week).count
    # ページングを適用して表示するレコードを取得
    @planted_flowers = current_user.planted_flowers.includes(:flower).order(added_at: :asc).page(params[:page])
  end
end

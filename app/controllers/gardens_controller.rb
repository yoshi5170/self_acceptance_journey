class GardensController < ApplicationController
  def show
    @planted_flowers = current_user.planted_flowers.includes(:unlockable_flower).order(added_at: :desc).page(params[:page])
    @total_flowers_count = @planted_flowers.count
    @weekly_flowers_count = @planted_flowers.where("added_at >= ?", Time.current.beginning_of_week).count
  end
end

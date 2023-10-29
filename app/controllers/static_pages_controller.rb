class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!
  def top; end
  def terms; end
  def privacy; end
end

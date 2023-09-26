class StaticPagesController < ApplicationController
  skip_before_action :require_login
  def top; end
  def terms; end
  def privacy; end
end

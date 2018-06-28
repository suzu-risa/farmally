class HomeController < ApplicationController
  def index
    @category = Category.all
  end

  def terms; end

  def privacy; end

  def commercial; end

  def company; end
end

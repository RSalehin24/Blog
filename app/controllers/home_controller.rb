class HomeController < ApplicationController
  def index
    @categories = Category.all.order(:name)
    @categories_array = Array.new
    @categories.each do |category|
      @categories_array.push([category.name, category.id])
    end
  end

  def about_us
  end
end

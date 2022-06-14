class SearchController < ApplicationController
  before_action :authenticate_user!

  def get_searched_posts
    @search_term = params["search_string"]
    @category_id = params["category_id"]
    
    if @category_id.nil? && @search_term.empty?
      redirect_to root_path
    elsif !@search_term.empty? && @category_id.nil?
      @searched_posts = Post.where(is_approved: true).where("lower(title) LIKE lower(?)", "%#{@search_term}%")
    elsif !@category_id.nil? && @search_term.empty?
      @searched_posts = Post.where(is_approved: true).where(category_id: @category_id)
    elsif !@category_id.nil? && !@search_term.empty?
      @searched_posts = Post.where(is_approved: true).where(category_id: @category_id).where("lower(title) LIKE lower(?)", "%#{@search_term}%")
    end
  end

end
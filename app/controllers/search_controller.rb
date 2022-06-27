class SearchController < ApplicationController
  before_action :authenticate_user!

  def get_searched_posts
    @search_type = params["search_type"]
    @is_user = false

    if @search_type.nil?
      redirect_to root_path, notice: "Search Type can't be empty!"
    elsif
      @search_term = params["search_string"]
      @followers = current_user.followers
      @requesters = current_user.requesters

      if @search_type == "User"
        @search_term = params["search_string"]
        @is_user = true

        if @search_term.empty?
          redirect_to root_path, notice: "Please write a Username to search!"
        else
          @searched_users = User.where.not(id: current_user.id).where("lower(username) LIKE lower(?)", "%#{@search_term}%")
        end

      elsif @search_type == "Post"

        @category_id = params["category_id"]

        if @category_id.nil? && @search_term.empty?
          redirect_to root_path, notice: "Please insert Category or Post title or both to search!"
        elsif !@search_term.empty? && @category_id.empty?
          @searched_posts = Post.where(is_approved: true).where("lower(title) LIKE lower(?)", "%#{@search_term}%")
        elsif !@category_id.nil? && @search_term.empty?
          @searched_posts = Post.where(is_approved: true).where(category_id: @category_id)
        elsif !@category_id.nil? && !@search_term.empty?
          @searched_posts = Post.where(is_approved: true).where(category_id: @category_id).where("lower(title) LIKE lower(?)", "%#{@search_term}%")
        end

      else
        redirect_to root_path, notice: "Wrong Search Type!"
      end

    end
  end
end
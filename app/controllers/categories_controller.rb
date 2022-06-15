class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[ show edit update destroy ]
  before_action :for_admin, only: [ :index, :show, :new, :edit, :create, :update, :destroy ] 
  
  # GET /categories or /categories.json
  def index
    @categories = Category.all.order(:name);
  end

  # GET /categories/1 or /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id]);
  end

  # POST /categories or /categories.json
  def create
    @categories = Category.all
    @is_empty = @categories.empty?
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.turbo_stream
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("alerts42", partial: "layouts/alerts", locals: { notice: "The Category already exists" }) }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.turbo_stream
      #  format.json { render :show, status: :ok, location: @category }
      #else
      #  format.html { render :edit, status: :unprocessable_entity }
      # format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy
    @categories = Category.all
    @is_empty = @categories.empty?

    respond_to do |format|
      format.turbo_stream
    end
  end

  def for_admin
    redirect_to posts_path, notice: "Not a path for you!" if !current_user.is_admin?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name)
    end
end

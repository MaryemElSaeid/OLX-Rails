class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
 

  # GET /products
  # GET /products.json
  def index
    # @products = Product.all.order("created_at desc").includes(:brand)
    # # @products = Product.all.includes(:brand)
    # @products = @products.filter_by_title(params[:title]) if params[:title].present?
    if params['category'].blank? or params['category']['id'].blank? 
      @products = Product.all.order("created_at desc").includes(:brand)
    elsif
      category = Category.find(params['category']['id']) 
      @products = category.products 
    elsif
      brand = Brand.find(params['brand']['id']) 
      @products = brand.products 
      end 
      @products = @products.search(params[:keywords]).order('created_at DESC') 
      
  end


  # GET /products/1
  # GET /products/1.json
  def show
    # brand=Brand.find(params[:product][:brand_name])
    # @brands =@products.brand.find(:all, :order => 'name')
    @products = Product.all
  end

  # GET /products/new
  def new
    @product = current_user.products.build
    # @user = User.find params[:id]
    # @user.income_pictures #-> collection of income pictures :)
    @category=Category.all()
    @brand=Brand.all()
    @store=Store.all()
   

    # @brand.products
    # @product = @brand.products.all.order("created_at desc")
    
  end

  # GET /products/1/edit
  def edit
    @category=Category.all()
    @brand=Brand.all()
    @store=Store.all()
  end

  # POST /products
  # POST /products.json
  def create
    @brands = Brand.all
    @categories = Category.all
    @stores = Store.all
    brand=Brand.find(params[:product][:brand_name])
    category=Category.find(params[:product][:category_id])
    store=Store.find(params[:product][:store_id])


    @product = brand.products.new(product_params)
    @product.user_id=current_user.id
    
    # @product = current_user.products.build(product_params)
    # byebug
    # @product=@brand.products.build(params[:product])
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'product was successfully created.' }
        format.json { render :show, status: :created, location: @product}
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @brands = Brand.all
    @categories = Category.all
    @stores = Store.all
    brand=Brand.find(params[:product][:brand_name])
    category=Category.find(params[:product][:category_id])
    store=Store.find(params[:product][:store_id])
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :price, :instock_quantity, :image, :brand_name, :category_id, :store_id)
    end
end
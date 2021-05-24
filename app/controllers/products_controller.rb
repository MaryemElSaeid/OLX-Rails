class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
 
  def index

    if params['category'].blank? or params['category']['id'].blank? 
    @products = Product.all.order("created_at desc").includes(:brand) 

    else
      category = Category.find(params['category']['id']) 
      @products = category.products 

      brand = Brand.find(params['brand']['id']) 
      @products = brand.products 

      user = User.find(params['user']['id']) 
      @products = user.products 

      end 
      @products = @products.search(params[:keywords]).order('created_at DESC') 
      
  end

  def show
    @products = Product.all
  end

  def new
    @product = current_user.products.build
 
    @category=Category.all()
    @brand=Brand.all()
    @store=Store.all()
   

    
  end


  def edit
    @category=Category.all()
    @brand=Brand.all()
    @store=Store.all()
  end

  def create
    @brands = Brand.all
    @categories = Category.all
    @stores = Store.all
    brand=Brand.find(params[:product][:brand_name])
    category=Category.find(params[:product][:category_id])
    store=Store.find(params[:product][:store_id])


    @product = brand.products.new(product_params)
    @product.user_id=current_user.id

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'created.' }
        format.json { render :show, status: :created, location: @product}
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @brands = Brand.all
    @categories = Category.all
    @stores = Store.all
    brand=Brand.find(params[:product][:brand_name])
    category=Category.find(params[:product][:category_id])
    store=Store.find(params[:product][:store_id])
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'destroyed.' }
      format.json { head :no_content }
    end
  end

  private
   
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :description, :price, :instock_quantity, :image, :brand_name, :category_id, :store_id)
    end
end
class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]
  before_action :set_cart, only: [:create]

  def index
    @line_items = LineItem.all
    
  end

  def show

  end


  def new
    @line_item = LineItem.new
  end

  def edit
  end

  # instock_quantity --1
  def create
    product = Product.find(params[:product_id])
    # byebug
    @line_item = @cart.add_product(product)
    product.update_columns(instock_quantity: product.instock_quantity - 1)
    # @product.instock_quantity --
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart, notice: 'Item add' }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

# Remove a specific item from the cart --> instock_quantity ++1
  def destroy
    product = Product.find(@line_item['product_id'])
    product.update_columns(instock_quantity: product.instock_quantity + 1)
    @cart = Cart.find(session[:cart_id])
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to cart_path(@cart), notice: 'removed.' }
      format.json { head :no_content }
    end
  
  end



  private

    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

      def line_item_params
      params.require(:line_item).permit(:product_id)
    end
end




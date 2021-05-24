class CartsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  #hena ba retrieve kol l carts
  def index
    @carts = Cart.all
  end

  #hena ba3mel new cart
  def new
    @cart = Cart.new
  end
  

  #hena beist5dm l new 34an yenfz l 7agat ely feha

  #haibd2 y create l cart fe3ln

  def create
#hena est5dm l new
    @cart = Cart.new(cart_params)
# di function mafrod beta5od l format format w t respond to it
    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end



  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

# empty the whole cart
  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Cart destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_cart
      @cart = Cart.find(params[:id])
    end

    def cart_params
      params.fetch(:cart, {}).permit(:title, :price, :description, :image)
    end

    def invalid_cart
      logger.error "Attempt invalid  #{params[:id]}"
      redirect_to root_path, notice: "cart doesnt exist"
    end
end
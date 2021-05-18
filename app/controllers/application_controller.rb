class ApplicationController < ActionController::Base
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_cart
    include CurrentCart
    protect_from_forgery with: :exception
  
  
    
end

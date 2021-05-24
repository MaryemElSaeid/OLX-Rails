class BrandsController < InheritedResources::Base

  def index
    @brand = Brand.all
    end
    
    def new
    @brand = Brand.new
    end
    
    def create
    @brand = Brand.new(brand_params)
    if @brand.save
    redirect_to brands_path, :notice => 'brand posted!'
    else
    render 'new'
    end
    end
    
    def edit
    @brand = Brand.find(params[:id])
    end
    
    def update
    @brand = Brand.find(params[:id])
    if @brand.update_attributes(brand_params)
    redirect_to brands_path, :notice => 'brand posted!'
    else
    render 'new'
    end
    end
    
    def show
    @brand = Brand.find(params[:id])
    end
    
    def destroy
    @brand = Brand.find(params[:id])
    @brand.destroy
    redirect_to brands_path, :notice => 'brand deleted.'
    end
    
  
  

    def brand_params
      params.require(:brand).permit(:name)
    end

end

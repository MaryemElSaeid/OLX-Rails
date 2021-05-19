class StoresController < InheritedResources::Base

  private

    def store_params
      params.require(:store).permit(:name, :summary)
    end

end

ActiveAdmin.register Brand do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name
  #
  # or
  #
  # permit_params do
  #   permitted = [:name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # index do
    
  #   column :name
    
  # end

  # filter :name

  # form do |f|
  #   f.inputs "Admin Details" do
  #     f.input :name
  #   end
  #   f.actions
  # end

  # controller do
  #   def permitted_params
  #     params.permit brand: [:name ]
  #   end
  # end
  
end
